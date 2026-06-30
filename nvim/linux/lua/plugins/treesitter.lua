local parsers = {
  "bash", "c", "cpp", "css", "diff", "dockerfile", "go", "gomod", "gosum",
  "html", "javascript", "json", "lua", "luadoc", "make",
  "markdown", "markdown_inline", "python", "query", "regex", "rust",
  "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup({})

      local ts = require("nvim-treesitter")
      local installed = ts.get_installed and ts.get_installed("parsers") or {}
      local have = {}
      for _, p in ipairs(installed) do have[p] = true end
      local missing = {}
      for _, p in ipairs(parsers) do
        if not have[p] then table.insert(missing, p) end
      end
      if #missing > 0 then
        ts.install(missing):wait(60000)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
          if lang and pcall(vim.treesitter.start, ev.buf, lang) then
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldmethod = "expr"
            vim.wo.foldenable = false
          end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      local function sel(lhs, capture, desc)
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(capture, "textobjects")
        end, { desc = desc })
      end

      sel("af", "@function.outer", "function (outer)")
      sel("if", "@function.inner", "function (inner)")
      sel("ac", "@class.outer", "class (outer)")
      sel("ic", "@class.inner", "class (inner)")
      sel("aa", "@parameter.outer", "argument (outer)")
      sel("ia", "@parameter.inner", "argument (inner)")

      local function jump(fn, capture, desc)
        return function() fn(capture, "textobjects") end, { desc = desc }
      end

      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Prev function start" })
      vim.keymap.set({ "n", "x", "o" }, "]c", function()
        move.goto_next_start("@class.outer", "textobjects")
      end, { desc = "Next class start" })
      vim.keymap.set({ "n", "x", "o" }, "[c", function()
        move.goto_previous_start("@class.outer", "textobjects")
      end, { desc = "Prev class start" })
    end,
  },
}
