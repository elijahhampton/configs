return {
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
      render = "compact",
      stages = "fade",
      fps = 60,
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        view = "cmdline_popup",
        format = {
          cmdline     = { icon = "" },
          search_down = { icon = " " },
          search_up   = { icon = " " },
          filter      = { icon = "" },
          lua         = { icon = "" },
          help        = { icon = "" },
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = { enabled = true },
        hover = { enabled = true },
        progress = { enabled = true },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d+ lines yanked" },
              { find = "%d+ fewer lines" },
              { find = "%d+ more lines" },
            },
          },
          view = "mini",
        },
        {
          filter = { event = "msg_show", kind = "search_count" },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
    keys = {
      { "<leader>nl", function() require("noice").cmd("last") end,    desc = "Last message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Message history" },
      { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss notifications" },
    },
  },
}
