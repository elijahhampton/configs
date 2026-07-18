local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- flume.nvim and kanagawa.nvim both load eagerly (lazy=false) but neither
-- calls vim.cmd.colorscheme itself; this applies the default once both
-- have registered, so <leader>ut can toggle between them afterward.
autocmd("VimEnter", {
  group = augroup("apply_default_theme", { clear = true }),
  once = true,
  callback = function()
    local theme = require("config.theme")
    theme.apply(theme.themes[theme.current])
  end,
})

autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

autocmd({ "BufWinEnter", "FileType" }, {
  group = augroup("close_with_q", { clear = true }),
  pattern = { "qf", "help", "man", "lspinfo", "checkhealth", "fugitive", "fugitiveblame" },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = args.buf, silent = true })
  end,
})

-- Applies to every terminal buffer, not just toggleterm's (that one has its
-- own TermOpen autocmd scoped to toggleterm:// buffers with different keys).
autocmd("TermOpen", {
  group = augroup("terminal_insert", { clear = true }),
  callback = function(args)
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = args.buf })
    vim.cmd.startinsert()
  end,
})

autocmd("BufEnter", {
  group = augroup("terminal_autoinsert", { clear = true }),
  pattern = "term://*",
  callback = function() vim.cmd.startinsert() end,
})
