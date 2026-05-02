return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "hyper",
      shortcut_type = "letter",
      config = {
        week_header = { enable = true },
        shortcut = {
          { desc = " Update", group = "@property", action = "Lazy update", key = "u" },
          { icon = " ", desc = "Files",  group = "Label",          action = "Telescope find_files",   key = "f" },
          { icon = " ", desc = "Recent", group = "Number",         action = "Telescope oldfiles",     key = "r" },
          { icon = " ", desc = "Grep",   group = "DiagnosticHint", action = "Telescope live_grep",    key = "g" },
          { icon = " ", desc = "Config", group = "Function",       action = "edit ~/.config/nvim/init.lua", key = "c" },
          { icon = " ", desc = "Mason",  group = "Constant",       action = "Mason",                   key = "m" },
          { icon = " ", desc = "Quit",   group = "DiagnosticError",action = "qa",                      key = "q" },
        },
        project = { enable = true, limit = 6, icon = " ", label = " Recent Projects:" },
        mru = { limit = 8, icon = " ", label = " Recent Files:" },
        footer = { "", "  ready when you are." },
      },
    },
  },
}
