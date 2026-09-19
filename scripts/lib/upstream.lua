local paths = require("scripts.lib.paths")
local log = require("scripts.lib.log")
local M = {}

local function fail(message)
  log.error(message)
  error("static-noise sync: " .. message, 0)
end

local function read_json(path)
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok then
    fail("cannot read " .. path)
  end
  local ok_decode, value = pcall(vim.json.decode, table.concat(lines, "\n"))
  if not ok_decode then
    fail("invalid JSON in " .. path .. ": " .. tostring(value))
  end
  return value
end

local function write_file(path, lines)
  if vim.fn.writefile(lines, path) ~= 0 then
    fail("cannot write " .. path)
  end
end

local function write_json(path, value)
  write_file(path, { vim.json.encode(value) })
end

local function remember(path)
  if vim.fn.filereadable(path) == 1 then
    return { exists = true, lines = vim.fn.readfile(path) }
  end
  return { exists = false }
end

local function restore(path, backup)
  local result
  if backup.exists then
    result = vim.fn.writefile(backup.lines, path)
  else
    result = vim.fn.delete(path)
  end
  if result ~= 0 then
    fail("could not restore " .. path)
  end
end

local function validate_target(target)
  local repository = target.repository
  local version = target.version
  local hash = target.hash
  if type(repository) ~= "string" or not repository:match("^https://github.com/[%w_.-]+/[%w_.-]+/?$") then
    fail("target.json must contain a GitHub repository URL")
  end
  if type(hash) ~= "string" or #hash ~= 40 or not hash:match("^[0-9a-fA-F]+$") then
    fail("target.json must contain a 40-character commit hash")
  end
  if type(version) ~= "string" or not version:match("^%d+%.%d+%.%d+[%w%._%-]*$") then
    fail("target.json must contain a valid semantic version")
  end
  return repository, version, hash
end

local function download(repository, hash)
  local raw_url = repository:gsub("^https://github.com/", "https://raw.githubusercontent.com/"):gsub("/$", "")
    .. "/" .. hash .. "/palette.json"
  local payload = vim.fn.system({ "curl", "--fail", "--silent", "--show-error", "--location", raw_url })
  if vim.v.shell_error ~= 0 or payload == "" then
    fail("could not download palette.json from " .. repository .. " at " .. hash)
  end
  return payload
end

-- Validate the complete candidate before touching the checked-in snapshot.
-- The final commit is guarded by backups so a failed write restores the last known-good state.
local function commit_staged_files(stage, root)
  local destinations = {
    { stage .. "/upstream/palette.json", paths.snapshot(root) },
    { stage .. "/upstream/provenance.json", paths.provenance(root) },
    { stage .. "/lua/static-noise/palette.lua", paths.generated_palette(root) },
  }
  local backups = {}
  for _, pair in ipairs(destinations) do
    backups[pair[2]] = remember(pair[2])
  end

  local ok, commit_error = xpcall(function()
    for _, pair in ipairs(destinations) do
      write_file(pair[2], vim.fn.readfile(pair[1]))
    end
  end, debug.traceback)
  if not ok then
    for path, backup in pairs(backups) do
      restore(path, backup)
    end
    fail("commit failed and was rolled back: " .. commit_error)
  end
end

-- Synchronize one immutable upstream revision described by upstream/target.json.
function M.sync(root)
  log.info("reading upstream target: " .. paths.sync_target(root))
  local target = read_json(paths.sync_target(root))
  local repository, version, hash = validate_target(target)
  log.info("selected upstream revision: " .. hash)
  local stage = root .. "/.static-noise-sync-" .. tostring(vim.fn.getpid())
  vim.fn.mkdir(stage .. "/upstream", "p")
  vim.fn.mkdir(stage .. "/lua/static-noise", "p")

  local ok, sync_error = xpcall(function()
    log.info("downloading palette.json from " .. repository)
    local payload = download(repository, hash)
    log.success("download completed")
    local stage_snapshot = stage .. "/upstream/palette.json"
    local stage_provenance = stage .. "/upstream/provenance.json"
    local stage_palette = stage .. "/lua/static-noise/palette.lua"
    write_file(stage_snapshot, vim.split(payload, "\n", { plain = true, trimempty = true }))

    log.info("validating downloaded snapshot")
    local snapshot = read_json(stage_snapshot)
    if snapshot.version ~= version then
      fail("target.json version does not match palette.json version")
    end
    write_json(stage_provenance, {
      repository = repository,
      version = version,
      commit = hash,
      source = "palette.json",
      synced_at = os.date("!%Y-%m-%d"),
    })

    log.info("building staged palette")
    require("scripts.lib.build").run(root, stage_snapshot, stage_palette, true)
    log.info("validating staged runtime")
    require("scripts.lib.validate").run(root, stage_palette)
    log.info("committing validated snapshot")
    commit_staged_files(stage, root)
  end, debug.traceback)

  vim.fn.delete(stage, "rf")
  if not ok then
    fail(sync_error)
  end
  log.success("synchronized Static Noise " .. version .. " from " .. repository .. " at " .. hash)
end

return M
