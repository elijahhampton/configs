return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      focus = true,
      auto_close = true,
      win = { size = { height = 12 } },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                          desc = "Diagnostics (workspace)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",             desc = "Diagnostics (buffer)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                  desc = "Symbols panel" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",   desc = "LSP refs/defs/impl" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                              desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                               desc = "Quickfix list" },
    },
  },
}
