-- ==============================================================================
-- Static Noise — Highlight Groups Generator
-- ==============================================================================

local M = {}

function M.setup(p, config)
  local bg = config.transparent and "none" or p.base
  local bg_float = config.transparent and "none" or p.raised
  local bg_sidebar = config.transparent and "none" or p.void

  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Editor Base
  hl("Normal", { fg = p.text, bg = bg })
  hl("NormalNC", { fg = p.textSoft, bg = bg })
  hl("NormalFloat", { fg = p.text, bg = bg_float })
  hl("FloatBorder", { fg = p.borderFocus, bg = bg_float })
  hl("FloatTitle", { fg = p.cyan, bold = true, bg = bg_float })
  hl("Cursor", { fg = p.void, bg = p.cyan })
  hl("CursorLine", { bg = p.selection })
  hl("CursorLineNr", { fg = p.cyan, bold = true })
  hl("LineNr", { fg = p.disabled })
  hl("SignColumn", { bg = "none" })
  hl("ColorColumn", { bg = p.selection })
  hl("VertSplit", { fg = p.border, bg = "none" })
  hl("WinSeparator", { fg = p.border, bg = "none" })
  hl("StatusLine", { fg = p.text, bg = bg })
  hl("StatusLineNC", { fg = p.muted, bg = bg })

  -- Visual Selection y Búsqueda
  hl("Visual", { fg = p.text, bg = p.cyanDim })
  hl("VisualNOS", { fg = p.text, bg = p.cyanDim })
  hl("Search", { fg = p.yellow, bg = p.yellowDim })
  hl("IncSearch", { fg = p.void, bg = p.cyan, bold = true })
  hl("CurSearch", { fg = p.void, bg = p.cyan, bold = true })

  -- Pmenu (Autocompletado)
  hl("Pmenu", { fg = p.text, bg = p.raised })
  hl("PmenuSel", { fg = p.cyan, bg = p.cyanDim, bold = true })
  hl("PmenuSbar", { bg = p.overlay })
  hl("PmenuThumb", { bg = p.border })

  -- Sintaxis Estándar
  hl("Comment", { fg = p.muted, italic = config.styles.comments.italic })
  hl("Constant", { fg = p.orange })
  hl("String", { fg = p.green })
  hl("Character", { fg = p.green })
  hl("Number", { fg = p.orange })
  hl("Boolean", { fg = p.orange, bold = true })
  hl("Float", { fg = p.orange })
  hl("Identifier", { fg = p.text })
  hl("Function", { fg = p.blue, italic = config.styles.functions.italic })
  hl("Statement", { fg = p.pink, italic = config.styles.keywords.italic })
  hl("Conditional", { fg = p.pink, italic = config.styles.keywords.italic })
  hl("Repeat", { fg = p.pink, italic = config.styles.keywords.italic })
  hl("Label", { fg = p.pink })
  hl("Operator", { fg = p.cyan })
  hl("Keyword", { fg = p.pink, italic = config.styles.keywords.italic })
  hl("Exception", { fg = p.pink, bold = true })
  hl("PreProc", { fg = p.purple })
  hl("Include", { fg = p.pink, italic = config.styles.keywords.italic })
  hl("Type", { fg = p.purple })
  hl("StorageClass", { fg = p.purple })
  hl("Structure", { fg = p.purple })
  hl("Special", { fg = p.cyan })
  hl("SpecialChar", { fg = p.cyan })
  hl("Underlined", { underline = true })
  hl("Error", { fg = p.red, bold = true })
  hl("Todo", { fg = p.yellow, bold = true })

  -- Treesitter
  hl("@variable", { fg = p.text })
  hl("@variable.builtin", { fg = p.cyan })
  hl("@variable.parameter", { fg = p.textSoft })
  hl("@function", { fg = p.blue, italic = config.styles.functions.italic })
  hl("@function.builtin", { fg = p.blue })
  hl("@function.call", { fg = p.blue })
  hl("@method", { fg = p.blue })
  hl("@keyword", { fg = p.pink, italic = config.styles.keywords.italic })
  hl("@keyword.function", { fg = p.pink, italic = config.styles.keywords.italic })
  hl("@keyword.return", { fg = p.pink, italic = config.styles.keywords.italic })
  hl("@string", { fg = p.green })
  hl("@number", { fg = p.orange })
  hl("@boolean", { fg = p.orange, bold = true })
  hl("@type", { fg = p.purple })
  hl("@type.builtin", { fg = p.purple })
  hl("@property", { fg = p.text })
  hl("@field", { fg = p.text })
  hl("@punctuation.delimiter", { fg = p.textSoft })
  hl("@punctuation.bracket", { fg = p.textSoft })
  hl("@tag", { fg = p.cyan })
  hl("@tag.attribute", { fg = p.blue })
  hl("@tag.delimiter", { fg = p.textSoft })

  -- LSP y Diagnósticos
  hl("DiagnosticError", { fg = p.red })
  hl("DiagnosticWarn", { fg = p.orange })
  hl("DiagnosticInfo", { fg = p.blue })
  hl("DiagnosticHint", { fg = p.cyan })
  hl("DiagnosticUnderlineError", { undercurl = true, sp = p.red })
  hl("DiagnosticUnderlineWarn", { undercurl = true, sp = p.orange })
  hl("DiagnosticUnderlineInfo", { undercurl = true, sp = p.blue })
  hl("DiagnosticUnderlineHint", { undercurl = true, sp = p.cyan })

  -- GitSigns
  hl("GitSignsAdd", { fg = p.green })
  hl("GitSignsChange", { fg = p.blue })
  hl("GitSignsDelete", { fg = p.red })

  -- Neo-tree
  hl("NeoTreeNormal", { fg = p.text, bg = bg_sidebar })
  hl("NeoTreeNormalNC", { fg = p.textSoft, bg = bg_sidebar })
  hl("NeoTreeRootName", { fg = p.cyan, bold = true })
  hl("NeoTreeDirectoryIcon", { fg = p.cyan })
  hl("NeoTreeDirectoryName", { fg = p.text })
  hl("NeoTreeFileName", { fg = p.text })
  hl("NeoTreeGitAdded", { fg = p.green })
  hl("NeoTreeGitModified", { fg = p.blue })
  hl("NeoTreeGitDeleted", { fg = p.red })
  hl("NeoTreeGitUntracked", { fg = p.yellow })

  -- Telescope
  hl("TelescopeBorder", { fg = p.borderFocus, bg = bg_float })
  hl("TelescopePromptBorder", { fg = p.cyan, bg = bg_float })
  hl("TelescopeNormal", { fg = p.text, bg = bg_float })
  hl("TelescopeSelection", { fg = p.cyan, bg = p.cyanDim, bold = true })
  hl("TelescopeMatching", { fg = p.yellow, bold = true })

  -- Which-Key
  hl("WhichKey", { fg = p.cyan, bold = true })
  hl("WhichKeyGroup", { fg = p.blue })
  hl("WhichKeyDesc", { fg = p.text })
  hl("WhichKeySeparator", { fg = p.muted })
  hl("WhichKeyFloat", { bg = bg_float })
end

return M
