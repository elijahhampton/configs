return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({ check_ts = true })

      local ok, cmp = pcall(require, "cmp")
      if ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },

  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {},
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
  },

  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "lazy", "mason", "NvimTree", "TelescopePrompt" },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },
}
