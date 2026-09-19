local M = {}

function M.file(root, relative_path)
  return root .. "/" .. relative_path
end

function M.snapshot(root)
  return M.file(root, "upstream/palette.json")
end

function M.sync_target(root)
  return M.file(root, "upstream/target.json")
end

function M.provenance(root)
  return M.file(root, "upstream/provenance.json")
end

function M.generated_palette(root)
  return M.file(root, "lua/static-noise/palette.lua")
end

return M
