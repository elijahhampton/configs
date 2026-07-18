local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- <Cmd> (not <cmd>...<CR>) runs without leaving the current mode, so these
-- also work mid-terminal-mode without kicking you out of insert. Avoiding
-- <C-Tab>/<C-S-Tab> here: Ghostty claims those as built-in tab-switch
-- defaults before nvim ever sees the keystroke.
map({ "n", "i", "t" }, "<C-.>", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map({ "n", "i", "t" }, "<C-,>", "<Cmd>tabprevious<CR>", { desc = "Prev tab" })

-- Normal/terminal only (not insert): <Tab>/<S-Tab> are already owned by
-- nvim-cmp for completion in insert mode. <Cmd> keeps terminal-mode from
-- being kicked to normal mode, and terminal-mode mappings intercept the key
-- before it reaches the job (e.g. Claude Code), so this works even there.
map({ "n", "t" }, "<Tab>", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map({ "n", "t" }, "<S-Tab>", "<Cmd>tabprevious<CR>", { desc = "Prev tab" })

map("n", "<leader><Tab>", "<cmd>tabnew<CR>", { desc = "New tab" })

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

map("n", "<leader>ut", function() require("config.theme").toggle() end, { desc = "Toggle theme (flume/kanagawa-dragon)" })
