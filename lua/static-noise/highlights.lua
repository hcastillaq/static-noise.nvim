local M = {}

local modules = {
  require("static-noise.highlights.base"),
  require("static-noise.highlights.syntax"),
  require("static-noise.highlights.treesitter"),
  require("static-noise.highlights.lsp"),
  require("static-noise.highlights.plugins"),
}

local ALLOWED_ATTRIBUTES = {
  link = true,
  bold = true,
  italic = true,
  underline = true,
  undercurl = true,
  reverse = true,
  strikethrough = true,
  nocombine = true,
  sp = true,
  fg = true,
  bg = true,
}

local function validate(name, spec)
  if type(name) ~= "string" or type(spec) ~= "table" then
    error("static-noise: invalid highlight definition")
  end
  if spec.link then
    for key in pairs(spec) do
      if key ~= "link" then
        error("static-noise: highlight " .. name .. " combines link with " .. key)
      end
    end
  end
  for key, value in pairs(spec) do
    if not ALLOWED_ATTRIBUTES[key] then
      error("static-noise: unsupported attribute " .. key .. " in " .. name)
    end
    if (key == "fg" or key == "bg" or key == "sp") and value ~= "none" and (type(value) ~= "string" or not value:match("^#%x%x%x%x%x%x$")) then
      error("static-noise: invalid color in " .. name .. "." .. key)
    end
  end
end

function M.setup(colors, config)
  local definitions = {}
  for _, module in ipairs(modules) do
    for name, spec in pairs(module(colors, config)) do
      if definitions[name] then
        error("static-noise: duplicate highlight " .. name)
      end
      validate(name, spec)
      definitions[name] = spec
    end
  end
  for name, spec in pairs(definitions) do
    vim.api.nvim_set_hl(0, name, spec)
  end
end

return M
