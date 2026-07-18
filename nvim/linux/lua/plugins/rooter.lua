-- auto-cd to root of git project (repos live under ~/Git)
return {
  {
    "notjedi/nvim-rooter.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-rooter").setup()
    end,
  },
}
