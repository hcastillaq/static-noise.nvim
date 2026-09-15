-- ==============================================================================
-- Static Noise — Colorscheme Plugin for Neovim
-- ==============================================================================

local M = {}

M.config = {
  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
  },
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = "static-noise"
  vim.o.termguicolors = true

  local palette = require("static-noise.palette")
  local highlights = require("static-noise.highlights")

  highlights.setup(palette, M.config)
end

return M
