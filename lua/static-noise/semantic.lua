local M = {}

local function required(root, path)
  local value = root
  for segment in path:gmatch("[^.]+") do
    value = value and value[segment]
  end
  if type(value) ~= "string" or not value:match("^#%x%x%x%x%x%x$") then
    error("static-noise: missing or invalid semantic token " .. path)
  end
  return value
end

function M.resolve(palette, transparent)
  local function color(path)
    return required(palette, path)
  end

  local colors = {
    surface = {
      canvas = color("semantic.surface.canvas"),
      base = color("semantic.surface.base"),
      elevated = color("semantic.surface.elevated"),
      elevated_hover = color("semantic.surface.elevatedHover"),
      selection = color("semantic.surface.selection"),
    },
    content = {
      primary = color("semantic.content.primary"),
      secondary = color("semantic.content.secondary"),
      muted = color("semantic.content.muted"),
      subtle = color("semantic.content.subtle"),
    },
    outline = {
      subtle = color("semantic.outline.subtle"),
      strong = color("semantic.outline.strong"),
    },
    interaction = {
      focus = color("semantic.interaction.focus"),
      on_focus = color("semantic.interaction.onFocus"),
    },
    status = {
      success = color("semantic.status.success"),
      warning = color("semantic.status.warning"),
      danger = color("semantic.status.danger"),
    },
    syntax = {
      function_ = color("domains.syntax.function"),
      keyword = color("domains.syntax.keyword"),
      string = color("domains.syntax.string"),
      type = color("domains.syntax.type"),
      constant = color("domains.syntax.constant"),
      preprocessor = color("domains.syntax.preprocessor"),
      error = color("domains.syntax.error"),
    },
    diff = {
      added = color("domains.diff.added"),
      added_emphasis = color("domains.diff.addedEmphasis"),
      removed = color("domains.diff.removed"),
      removed_emphasis = color("domains.diff.removedEmphasis"),
    },
    ansi = palette.projections.ansi,
  }

  colors.surface.root = transparent and "none" or colors.surface.base
  colors.surface.sidebar = transparent and "none" or colors.surface.canvas
  colors.surface.popup = colors.surface.elevated
  colors.surface.statusline = colors.surface.base
  colors.surface.transparent = "none"
  return colors
end

return M
