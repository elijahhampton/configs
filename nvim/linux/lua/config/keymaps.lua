local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

map("n", "-", "<cmd>Oil<CR>", { desc = "Open parent dir (oil)" })
map("n", "<leader>-", "<cmd>Oil --float<CR>", { desc = "Oil (float)" })

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "File tree" })
map("n", "<leader>E", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal in tree" })

map("n", "<leader>?", function() require("util.cheatsheet").toggle() end, { desc = "Toggle cheatsheet" })
map("n", "<F1>", function() require("util.cheatsheet").toggle() end, { desc = "Toggle cheatsheet" })
