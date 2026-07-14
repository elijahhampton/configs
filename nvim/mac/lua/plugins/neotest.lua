return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
      "marilari88/neotest-vitest",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Test: run nearest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: run file" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Test: run last" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Test: stop" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test: toggle summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: output (nearest)" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Test: toggle output panel" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-golang")({}),
          require("neotest-vitest")({
            filter_dir = function(name, rel_path, root)
              return name ~= "node_modules"
            end,
          }),
        },
      })
    end,
  },
}
