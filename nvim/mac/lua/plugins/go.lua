return {
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("gopher").setup({})

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function(ev)
          local function map(k, cmd, desc)
            vim.keymap.set("n", k, cmd, { buffer = ev.buf, desc = desc })
          end
          map("<leader>gsj", "<cmd>GoTagAdd json<CR>",    "Add json tags")
          map("<leader>gsy", "<cmd>GoTagAdd yaml<CR>",    "Add yaml tags")
          map("<leader>gsr", "<cmd>GoTagRm json<CR>",     "Remove json tags")
          map("<leader>gie", "<cmd>GoIfErr<CR>",          "if err != nil")
          map("<leader>gtf", "<cmd>GoTestAdd<CR>",        "Generate test for func")
          map("<leader>gta", "<cmd>GoTestsAll<CR>",       "Generate tests (all)")
          map("<leader>gte", "<cmd>GoTestsExp<CR>",       "Generate tests (exported)")
        end,
      })
    end,
  },
}
