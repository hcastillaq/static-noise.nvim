local root = vim.fn.getcwd()
package.path = root .. "/?.lua;" .. root .. "/?/init.lua;" .. package.path
require("scripts.lib.validate").run(root)

local function rgb(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false }).fg
end

local warning = tonumber("EDD071", 16)
local success = tonumber("A3D98B", 16)
local focus = tonumber("72EAD5", 16)
assert(rgb("SnacksPickerGitStatusUntracked") == warning, "Snacks untracked highlight mismatch")
assert(rgb("SnacksPickerGitStatusAdded") == success, "Snacks added highlight mismatch")
assert(rgb("SnacksPickerGitStatusStaged") == focus, "Snacks staged highlight mismatch")
assert(vim.api.nvim_get_hl(0, { name = "SnacksPickerGitStatusUntracked", link = false }).bold == true, "Snacks untracked should be emphasized")
assert(rgb("DiffAdd") == tonumber("A3D98B", 16), "DiffAdd highlight mismatch")

local lualine = require("lualine.themes.static-noise")
assert(lualine.normal.z.bg == "#242B3D", "Lualine normal z should have an explicit anchor")
assert(lualine.normal.a.bg == "#222738", "Lualine normal mode should use a calm elevated surface")
assert(lualine.normal.a.fg == "#E6E2D6", "Lualine normal mode should use readable primary text")
assert(lualine.normal.b.bg ~= lualine.normal.c.bg, "Lualine powerline sections need distinct surfaces")
assert(lualine.inactive.a.bg ~= lualine.inactive.b.bg, "Inactive powerline sections should remain visible")

require("static-noise").setup({ transparent = true })
vim.cmd.colorscheme("static-noise")
assert(vim.api.nvim_get_hl(0, { name = "SnacksPicker", link = false }).bg == nil, "Snacks Explorer should inherit a transparent background")
assert(vim.api.nvim_get_hl(0, { name = "SnacksPickerList", link = false }).bg == nil, "Snacks Explorer list should inherit a transparent background")
