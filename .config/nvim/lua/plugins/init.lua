return {
  {
    "stevearc/conform.nvim",
    { "tpope/vim-surround", lazy = false },
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    keys = { "ys", "ds", "cs" },
    config = function()
      require("nvim-surround").setup({})
    end,
  },
}
