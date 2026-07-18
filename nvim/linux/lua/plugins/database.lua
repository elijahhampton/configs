return {
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI" },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>Du", "<cmd>DBUIToggle<CR>", desc = "Database: toggle UI" },
      { "<leader>Da", "<cmd>DBUIAddConnection<CR>", desc = "Database: add connection" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<CR>", desc = "Database: find buffer" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod-ui"
    end,
  },

  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "tpope/vim-dadbod", "hrsh7th/nvim-cmp" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" }, { name = "buffer" } } })
        end,
      })
    end,
  },
}
