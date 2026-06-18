return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "BufReadPre", 
    config = function()
      require("nvim-surround").setup({})
    end,
  },
}
