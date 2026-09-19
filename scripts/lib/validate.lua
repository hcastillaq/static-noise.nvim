local log = require("scripts.lib.log")
local M = {}

local function fail(message)
  log.error(message)
  error("static-noise validation: " .. message, 0)
end

local function assert_true(condition, message)
  if not condition then
    fail(message)
  end
end

local function validate_palette(node, path)
  if type(node) ~= "table" then
    assert_true(type(node) == "string" and node:match("^#%x%x%x%x%x%x$"), "invalid generated token " .. path)
    return
  end
  for key, value in pairs(node) do
    validate_palette(value, path .. "." .. key)
  end
end

local function inspect(palette, semantic, transparency)
  vim.g.colors_name = nil
  require("static-noise").setup({ transparent = transparency })
  vim.cmd("colorscheme static-noise")
  assert_true(vim.g.colors_name == "static-noise", "colorscheme name was not set")

  local colors = semantic.resolve(palette, transparency)
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local float = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
  local border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
  assert_true(normal.fg == tonumber(colors.content.primary:sub(2), 16), "Normal foreground mismatch")
  if transparency then
    assert_true(normal.bg == nil, "transparent Normal background should be absent")
  else
    assert_true(normal.bg == tonumber(colors.surface.base:sub(2), 16), "opaque Normal background mismatch")
  end
  assert_true(float.bg == tonumber(colors.surface.elevated:sub(2), 16), "elevated float background mismatch")
  assert_true(border.fg == tonumber(colors.outline.strong:sub(2), 16), "border foreground mismatch")

  local linked = vim.api.nvim_get_hl(0, { name = "@comment", link = true })
  assert_true(linked.link == "Comment", "Tree-sitter comment link mismatch")
  local effective = vim.api.nvim_get_hl(0, { name = "@comment", link = false })
  local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
  assert_true(effective.fg == comment.fg, "linked comment color mismatch")
  assert_true(vim.api.nvim_get_hl(0, { name = "Keyword", link = false }).italic == true, "keyword style option was not applied")
end

function M.run(root, palette_path)
  root = root or vim.fn.getcwd()
  palette_path = palette_path or root .. "/lua/static-noise/palette.lua"
  log.info("loading generated palette: " .. palette_path)
  vim.opt.runtimepath:prepend(root)
  package.loaded["static-noise.palette"] = nil
  package.preload["static-noise.palette"] = function()
    return dofile(palette_path)
  end
  local palette = require("static-noise.palette")
  local semantic = require("static-noise.semantic")
  validate_palette(palette, "palette")
  assert_true(palette.highlights == nil, "generated palette contains highlight definitions")
  log.info("checking transparent colorscheme")
  inspect(palette, semantic, true)
  log.info("checking opaque colorscheme")
  inspect(palette, semantic, false)
  log.success("colorscheme validation passed")
end

return M
