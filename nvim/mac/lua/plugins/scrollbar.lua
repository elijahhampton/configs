return {
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      require("scrollbar").setup({
        show = true,
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true,
          handle = true,
          search = false,
          ale = false,
        },
        marks = {
          Cursor = { text = "" },
          Search = { text = { "-", "=" } },
          Error = { text = { "-", "=" } },
          Warn = { text = { "-", "=" } },
          Info = { text = { "-", "=" } },
          Hint = { text = { "-", "=" } },
          Misc = { text = { "-", "=" } },
        },
        excluded_filetypes = {
          "cheatsheet",
          "dashboard",
          "NvimTree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "TelescopePrompt",
          "TelescopeResults",
          "noice",
          "notify",
          "help",
        },
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
}
