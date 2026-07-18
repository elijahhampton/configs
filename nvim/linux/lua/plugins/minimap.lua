local exclude_filetypes = {
  cheatsheet = true,
  dashboard = true,
  NvimTree = true,
  Trouble = true,
  trouble = true,
  lazy = true,
  mason = true,
  TelescopePrompt = true,
  TelescopeResults = true,
  noice = true,
  notify = true,
  help = true,
}

return {
  {
    "echasnovski/mini.map",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local map = require("mini.map")
      map.setup({
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diagnostic(),
          map.gen_integration.gitsigns(),
        },
        window = {
          width = 20,
          winblend = 15,
          focusable = true,
        },
      })
      -- opening a window synchronously here can run inside the startup /
      -- BufReadPost textlock (E565: Not allowed to change text or change
      -- window); defer to the next tick, after that context has cleared.
      vim.schedule(function() map.open() end)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("minimap_exclude", { clear = true }),
        callback = function(ev)
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(ev.buf) then return end
            if exclude_filetypes[vim.bo[ev.buf].filetype] then
              map.close()
            else
              map.open()
            end
          end)
        end,
      })
    end,
    keys = {
      { "<leader>mm", function() require("mini.map").toggle() end, desc = "Minimap: toggle" },
      { "<leader>mo", function() require("mini.map").open() end, desc = "Minimap: open" },
      { "<leader>mc", function() require("mini.map").close() end, desc = "Minimap: close" },
      { "<leader>mf", function() require("mini.map").toggle_focus() end, desc = "Minimap: focus (navigate)" },
      { "<leader>ms", function() require("mini.map").toggle_side() end, desc = "Minimap: toggle side" },
      { "<leader>mr", function() require("mini.map").refresh() end, desc = "Minimap: refresh" },
    },
  },
}
