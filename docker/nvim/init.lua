local lazypath = "/root/.local/share/nvim/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.o.termguicolors = true
vim.o.number = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.mouse = "a"

require("lazy").setup(require("config.plugins"), {
  change_detection = { notify = false },
  checker = { enabled = false },
  install = { colorscheme = { "static-noise" } },
})

vim.opt.rtp:prepend("/root/.local/share/nvim/site/pack/colors/start/static-noise.nvim")
vim.cmd.colorscheme("static-noise")

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File tree" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
vim.keymap.set("n", "s", function()
  require("flash").jump()
end, { desc = "Flash jump" })
