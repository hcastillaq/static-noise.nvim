return function(c, config)
  local keyword_italic = config.styles.keywords.italic
  local function_italic = config.styles.functions.italic
  return {
    ["@comment"] = { link = "Comment" },
    ["@constant"] = { link = "Constant" },
    ["@string"] = { link = "String" },
    ["@number"] = { link = "Number" },
    ["@boolean"] = { link = "Boolean" },
    ["@variable"] = { link = "Identifier" },
    ["@variable.builtin"] = { fg = c.interaction.focus },
    ["@variable.parameter"] = { fg = c.content.secondary },
    ["@function"] = { fg = c.syntax.function_, italic = function_italic },
    ["@function.builtin"] = { fg = c.syntax.function_ },
    ["@function.call"] = { fg = c.syntax.function_ },
    ["@method"] = { fg = c.syntax.function_ },
    ["@keyword"] = { fg = c.syntax.keyword, italic = keyword_italic },
    ["@keyword.function"] = { fg = c.syntax.keyword, italic = keyword_italic },
    ["@keyword.return"] = { fg = c.syntax.keyword, italic = keyword_italic },
    ["@type"] = { fg = c.syntax.type },
    ["@type.builtin"] = { fg = c.syntax.type },
    ["@property"] = { fg = c.content.primary },
    ["@field"] = { fg = c.content.primary },
    ["@punctuation.delimiter"] = { fg = c.content.secondary },
    ["@punctuation.bracket"] = { fg = c.content.secondary },
    ["@operator"] = { link = "Operator" },
    ["@tag"] = { fg = c.interaction.focus },
    ["@tag.attribute"] = { fg = c.syntax.function_ },
    ["@tag.delimiter"] = { fg = c.content.secondary },
  }
end
