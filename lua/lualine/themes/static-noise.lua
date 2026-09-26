local palette = require("static-noise.palette")
local colors = require("static-noise.semantic").resolve(palette, false)

local surfaces = {
  a = colors.surface.elevated_hover,
  b = colors.surface.elevated,
  c = colors.surface.statusline,
  z = colors.surface.selection,
}

local function sections(active_fg, active_bg)
  return {
    a = { fg = active_fg, bg = active_bg, gui = "bold" },
    b = { fg = colors.content.primary, bg = surfaces.b },
    c = { fg = colors.content.secondary, bg = surfaces.c },
    x = { fg = colors.content.secondary, bg = surfaces.c },
    y = { fg = colors.content.primary, bg = surfaces.b },
    z = { fg = colors.content.secondary, bg = surfaces.z },
  }
end

local theme = {
  normal = sections(colors.content.primary, surfaces.a),
  insert = sections(colors.interaction.on_focus, colors.status.success),
  visual = sections(colors.interaction.on_focus, colors.syntax.function_),
  replace = sections(colors.interaction.on_focus, colors.status.danger),
  command = sections(colors.interaction.on_focus, colors.status.warning),
  terminal = sections(colors.interaction.on_focus, colors.status.success),
  inactive = {
    a = { fg = colors.content.muted, bg = colors.surface.elevated },
    b = { fg = colors.content.muted, bg = colors.surface.statusline },
    c = { fg = colors.content.subtle, bg = colors.surface.canvas },
    x = { fg = colors.content.subtle, bg = colors.surface.canvas },
    y = { fg = colors.content.muted, bg = colors.surface.statusline },
    z = { fg = colors.content.muted, bg = colors.surface.elevated },
  },
}

return theme
