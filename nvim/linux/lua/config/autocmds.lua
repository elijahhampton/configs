local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.winrestview(save)
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
