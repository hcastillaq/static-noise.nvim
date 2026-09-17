-- Static Noise Lualine theme.
-- Loaded automatically by Lualine when `options.theme = "auto"`.

local palette = require("static-noise.palette")
local statusline = { fg = palette.textSoft, bg = palette.raised }

return {
  normal = {
    a = { fg = palette.cyan, bg = palette.raised, gui = "bold" },
    b = statusline,
    c = statusline,
  },
  insert = {
    a = { fg = palette.green, bg = palette.raised, gui = "bold" },
    b = statusline,
    c = statusline,
  },
  visual = {
    a = { fg = palette.purple, bg = palette.raised, gui = "bold" },
    b = statusline,
    c = statusline,
  },
  replace = {
    a = { fg = palette.red, bg = palette.raised, gui = "bold" },
    b = statusline,
    c = statusline,
  },
  command = {
    a = { fg = palette.yellow, bg = palette.raised, gui = "bold" },
    b = statusline,
    c = statusline,
  },
  inactive = {
    a = { fg = palette.muted, bg = palette.raised },
    b = statusline,
    c = statusline,
  },
}
