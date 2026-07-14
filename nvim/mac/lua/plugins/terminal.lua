return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal", mode = { "n", "t" } },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Terminal: vertical" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal: horizontal" },
      { "<leader>tF", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal: float" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then return 15 end
        if term.direction == "vertical" then return math.floor(vim.o.columns * 0.4) end
        return 20
      end,
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = { border = "rounded" },
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      close_on_exit = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = function(ev)
          local map = function(k, rhs) vim.keymap.set("t", k, rhs, { buffer = ev.buf }) end
          map("<esc>", [[<C-\><C-n>]])
          map("<C-h>", [[<Cmd>wincmd h<CR>]])
          map("<C-j>", [[<Cmd>wincmd j<CR>]])
          map("<C-k>", [[<Cmd>wincmd k<CR>]])
          map("<C-l>", [[<Cmd>wincmd l<CR>]])
        end,
      })
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
    },
  },
}
