return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "dragon",
      background = { dark = "dragon", light = "lotus" },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
    end,
  },

  {
    "mitander/flume.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("flume").setup(opts)
    end,
  },

  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    opts = {
      options = { transparent = false, dim_inactive = true },
    },
    config = function(_, opts)
      require("github-theme").setup(opts)
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "itchyny/lightline.vim",
    lazy = false, -- UI element, load at start
    config = function()
      -- no need to also show mode in cmd line when we have the bar
      vim.o.showmode = false
      vim.g.lightline = {
        active = {
          left = {
            { "mode", "paste" },
            { "readonly", "filename", "modified" },
          },
          right = {
            { "lineinfo" },
            { "percent" },
            { "fileencoding", "filetype" },
          },
        },
        component_function = {
          filename = "LightlineFilename",
        },
      }
      function LightlineFilenameInLua()
        if vim.fn.expand("%:t") == "" then
          return "[No Name]"
        else
          return vim.fn.getreg("%")
        end
      end
      -- https://github.com/itchyny/lightline.vim/issues/657
      vim.api.nvim_exec(
        [[
        function! g:LightlineFilename()
            return v:lua.LightlineFilenameInLua()
        endfunction
        ]],
        true
      )
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>n", group = "notifications" },
        { "<leader>u", group = "ui" },
        { "<leader>x", group = "diagnostics/quickfix" },
      },
    },
  },
}
