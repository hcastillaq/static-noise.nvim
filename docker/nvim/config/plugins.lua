return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "javascript", "lua", "vim" },
        callback = function(args)
          vim.treesitter.start(args.buf)
        end,
      })
    end,
  },
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({ options = { theme = "auto" } })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "lewis6991/gitsigns.nvim", config = true },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  { "folke/which-key.nvim", config = true },
  { "folke/flash.nvim", config = true },
  { "folke/trouble.nvim", config = true },
}
