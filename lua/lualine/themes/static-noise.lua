local palette = require("static-noise.palette")
local colors = require("static-noise.semantic").resolve(palette, false)

local theme = {
  normal = {
    a = { fg = colors.interaction.on_focus, bg = colors.interaction.focus, gui = "bold" },
    b = { fg = colors.content.primary, bg = colors.surface.elevated },
    c = { fg = colors.content.secondary, bg = colors.surface.statusline },
  },
  insert = {
    a = { fg = colors.interaction.on_focus, bg = colors.status.success, gui = "bold" },
    b = { fg = colors.content.primary, bg = colors.surface.elevated },
    c = { fg = colors.content.secondary, bg = colors.surface.statusline },
  },
  visual = {
    a = { fg = colors.interaction.on_focus, bg = colors.syntax.function_, gui = "bold" },
    b = { fg = colors.content.primary, bg = colors.surface.elevated },
    c = { fg = colors.content.secondary, bg = colors.surface.statusline },
  },
  replace = {
    a = { fg = colors.interaction.on_focus, bg = colors.status.danger, gui = "bold" },
    b = { fg = colors.content.primary, bg = colors.surface.elevated },
    c = { fg = colors.content.secondary, bg = colors.surface.statusline },
  },
  command = {
    a = { fg = colors.interaction.on_focus, bg = colors.status.warning, gui = "bold" },
    b = { fg = colors.content.primary, bg = colors.surface.elevated },
    c = { fg = colors.content.secondary, bg = colors.surface.statusline },
  },
  terminal = {
    a = { fg = colors.interaction.on_focus, bg = colors.status.success, gui = "bold" },
    b = { fg = colors.content.primary, bg = colors.surface.elevated },
    c = { fg = colors.content.secondary, bg = colors.surface.statusline },
  },
  inactive = {
    a = { fg = colors.content.muted, bg = colors.surface.statusline },
    b = { fg = colors.content.muted, bg = colors.surface.statusline },
    c = { fg = colors.content.subtle, bg = colors.surface.statusline },
  },
}

return theme
