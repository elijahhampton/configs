-- ------------------------------------------------------------
-- BASIC SETTINGS
-- ------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.wrap = false
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.mouse = "nv"
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.signcolumn = "yes"
opt.updatetime = 300
opt.timeoutlen = 500
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.termguicolors = true
opt.background = "dark"
opt.completeopt = { "menu", "menuone", "noselect" }

-- ------------------------------------------------------------
-- BOOTSTRAP LAZY.NVIM
-- ------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ------------------------------------------------------------
-- PLUGINS
-- ------------------------------------------------------------
require("lazy").setup({

    -- --------------------------------------------------------
    -- THEME — Catppuccin Mocha
    -- --------------------------------------------------------
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                background = { light = "latte", dark = "mocha" },
                transparent_background = true,
                show_end_of_buffer = false,
                term_colors = true,
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.15,
                },
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    trouble = true,
                    which_key = true,
                    harpoon = true,
                    noice = true,
                    notify = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors      = { "italic" },
                            hints       = { "italic" },
                            warnings    = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors      = { "underline" },
                            hints       = { "underline" },
                            warnings    = { "underline" },
                            information = { "underline" },
                        },
                        inlay_hints = { background = true },
                    },
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    -- --------------------------------------------------------
    -- ICONS
    -- --------------------------------------------------------
    { "nvim-tree/nvim-web-devicons" },

    -- --------------------------------------------------------
    -- OIL.NVIM — filesystem as an editable buffer
    -- --------------------------------------------------------
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                view_options = { show_hidden = true },
                columns = { "icon", "permissions", "size", "mtime" },
                keymaps = {
                    ["g?"]         = "actions.show_help",
                    ["<CR>"]       = "actions.select",
                    ["<C-v>"]      = "actions.select_vsplit",
                    ["<C-s>"]      = "actions.select_split",
                    ["<C-t>"]      = "actions.select_tab",
                    ["<C-p>"]      = "actions.preview",
                    ["<C-c>"]      = "actions.close",
                    ["<C-r>"]      = "actions.refresh",
                    ["-"]          = "actions.parent",
                    ["_"]          = "actions.open_cwd",
                    ["gs"]         = "actions.change_sort",
                    ["gx"]         = "actions.open_external",
                    ["g."]         = "actions.toggle_hidden",
                    ["<leader>nd"] = "actions.create_directory",
                    ["<leader>nf"] = "actions.create_file",
                },
                use_default_keymaps = false,
                float = { padding = 2, border = "rounded" },
            })
        end,
    },

    -- --------------------------------------------------------
    -- HARPOON — instant file pinning and jumping
    -- Pin files you're actively working in and jump between
    -- them with a single keypress. Per-project lists stored
    -- as JSON in ~/.local/share/nvim/harpoon/.
    -- --------------------------------------------------------
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true,
                },
            })

            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
                vim.notify("Harpoon: file added", vim.log.levels.INFO)
            end, { desc = "Harpoon: Add file" })

            vim.keymap.set("n", "<leader>hh", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "Harpoon: Toggle menu" })

            vim.keymap.set("n", "<C-1>", function()
                harpoon:list():select(1)
            end, { desc = "Harpoon: Go to file 1" })

            vim.keymap.set("n", "<C-2>", function()
                harpoon:list():select(2)
            end, { desc = "Harpoon: Go to file 2" })

            vim.keymap.set("n", "<C-3>", function()
                harpoon:list():select(3)
            end, { desc = "Harpoon: Go to file 3" })

            vim.keymap.set("n", "<C-4>", function()
                harpoon:list():select(4)
            end, { desc = "Harpoon: Go to file 4" })

            vim.keymap.set("n", "<leader>]", function()
                harpoon:list():next()
            end, { desc = "Harpoon: Next file" })

            vim.keymap.set("n", "<leader>[", function()
                harpoon:list():prev()
            end, { desc = "Harpoon: Prev file" })
        end,
    },

    -- --------------------------------------------------------
    -- FUZZY FINDER
    -- --------------------------------------------------------
    {
        "junegunn/fzf",
        build = function() vim.fn["fzf#install"]() end,
    },
    {
        "junegunn/fzf.vim",
        dependencies = { "junegunn/fzf" },
    },

    -- --------------------------------------------------------
    -- GIT
    -- --------------------------------------------------------
    { "tpope/vim-fugitive" },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "▎" },
                    change       = { text = "▎" },
                    delete       = { text = "" },
                    topdelete    = { text = "" },
                    changedelete = { text = "▎" },
                    untracked    = { text = "▎" },
                },
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 500,
                    virt_text_pos = "eol",
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> • <summary>",
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local m = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "Git: " .. desc })
                    end

                    m("]h", function()
                        if vim.wo.diff then return "]h" end
                        vim.schedule(function() gs.next_hunk() end)
                        return "<Ignore>"
                    end, "Next Hunk")
                    m("[h", function()
                        if vim.wo.diff then return "[h" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end, "Prev Hunk")

                    m("<leader>hs", gs.stage_hunk, "Stage Hunk")
                    m("<leader>hr", gs.reset_hunk, "Reset Hunk")
                    m("<leader>hS", gs.stage_buffer, "Stage Buffer")
                    m("<leader>hR", gs.reset_buffer, "Reset Buffer")
                    m("<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
                    m("<leader>hp", gs.preview_hunk, "Preview Hunk")
                    m("<leader>hd", gs.diffthis, "Diff This")
                    m("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
                    m("<leader>htb", gs.toggle_current_line_blame, "Toggle Line Blame")
                    m("<leader>htd", gs.toggle_deleted, "Toggle Deleted")
                end,
            })
        end,
    },

    -- --------------------------------------------------------
    -- STATUSLINE
    -- --------------------------------------------------------
    { "vim-airline/vim-airline" },

    -- --------------------------------------------------------
    -- AUTOPAIRS
    -- --------------------------------------------------------
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- --------------------------------------------------------
    -- WHICH KEY
    -- --------------------------------------------------------
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({})
        end,
    },

    -- --------------------------------------------------------
    -- NOICE.NVIM
    -- -- --------------------------------------------------------
    { "MunifTanjim/nui.nvim" },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                background_colour = "#1e1e2e", -- catppuccin mocha base
                timeout = 3000,
                render = "compact",
                stages = "fade",
                top_down = false,
            })
            vim.notify = require("notify")
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    progress = { enabled = true },
                    hover = { enabled = true },
                    signature = { enabled = true },
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                                { find = "%d fewer lines" },
                                { find = "%d more lines" },
                            },
                        },
                        opts = { skip = true },
                    },
                },
                presets = {
                    bottom_search = false,
                    command_palette = true,
                    long_message_to_split = true,
                    lsp_doc_border = true,
                },
            })
        end,
    },

    -- --------------------------------------------------------
    -- FORMATTER
    -- --------------------------------------------------------
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    rust       = { "rustfmt" },
                    go         = { "goimports", "gofmt" },
                    python     = { "black" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    lua        = { "stylua" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })
        end,
    },

    -- --------------------------------------------------------
    -- WRITING
    -- --------------------------------------------------------
    { "preservim/vim-pencil" },
    {
        "junegunn/goyo.vim",
        keys = {
            { "<leader>z", ":Goyo<CR>", desc = "Toggle Goyo" },
        },
    },
    {
        "junegunn/limelight.vim",
        keys = {
            { "<leader>l", ":Limelight!!<CR>", desc = "Toggle Limelight" },
        },
    },

    -- --------------------------------------------------------
    -- LSP INFRASTRUCTURE
    -- --------------------------------------------------------
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "rust_analyzer", "gopls" },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
    },

    -- --------------------------------------------------------
    -- RUST EXTRAS
    -- --------------------------------------------------------
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        ft = { "rust" },
    },

    -- --------------------------------------------------------
    -- GO EXTRAS
    -- --------------------------------------------------------
    {
        "ray-x/go.nvim",
        dependencies = { "ray-x/guihua.lua" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
        config = function()
            require("go").setup({
                lsp_cfg = false,
                lsp_gofumpt = true,
                lsp_on_attach = false,
            })
        end,
    },

    -- --------------------------------------------------------
    -- COMPLETION ENGINE
    -- --------------------------------------------------------
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- --------------------------------------------------------
    -- DIAGNOSTICS LIST
    -- --------------------------------------------------------
    {
        "folke/trouble.nvim",
        keys = {
            { "<leader>xx", ":TroubleToggle<CR>",                       desc = "Toggle Trouble" },
            { "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
            { "<leader>xd", ":TroubleToggle document_diagnostics<CR>",  desc = "Document Diagnostics" },
        },
        config = function()
            require("trouble").setup({})
        end,
    },

}, {
    ui = { border = "rounded" },
})

-- ------------------------------------------------------------
-- LSP ON_ATTACH
-- ------------------------------------------------------------
local on_attach = function(_, bufnr)
    local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition, "Go to Definition")
    map("gr", vim.lsp.buf.references, "Go to References")
    map("gy", vim.lsp.buf.type_definition, "Go to Type Definition")
    map("gi", vim.lsp.buf.implementation, "Go to Implementation")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("[g", vim.diagnostic.goto_prev, "Previous Diagnostic")
    map("]g", vim.diagnostic.goto_next, "Next Diagnostic")
    map("<leader>e", vim.diagnostic.open_float, "Show Diagnostic")

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- ------------------------------------------------------------
-- GOPLS
-- ------------------------------------------------------------
require("lspconfig").gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            hints = {
                assignVariableTypes    = true,
                compositeLiteralFields = true,
                constantValues         = true,
                functionTypeParameters = true,
                parameterNames         = true,
                rangeVariableTypes     = true,
            },
        },
    },
})

-- ------------------------------------------------------------
-- RUST ANALYZER (via rustaceanvim)
-- ------------------------------------------------------------
vim.g.rustaceanvim = {
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = { command = "clippy" },
                inlayHints = {
                    bindingModeHints  = { enable = true },
                    chainingHints     = { enable = true },
                    closingBraceHints = { enable = true },
                    parameterHints    = { enable = true },
                    typeHints         = { enable = true },
                },
                cargo = { allFeatures = true },
                procMacro = { enable = true },
            },
        },
    },
}

-- ------------------------------------------------------------
-- DIAGNOSTIC DISPLAY
-- ------------------------------------------------------------
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = "always" },
})

local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- ------------------------------------------------------------
-- GENERAL KEYMAPS
-- ------------------------------------------------------------
local map = vim.keymap.set

-- FZF
map("n", "<C-p>", ":Files<CR>", { desc = "FZF: Find Files" })
map("n", "<leader>ff", ":Files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", ":Rg<CR>", { desc = "Find by Grep" })

-- Oil
map("n", "<C-n>", ":Oil<CR>", { desc = "Open Oil" })
map("n", "-", ":Oil<CR>", { desc = "Open Oil" })
map("n", "<leader>-", ":Oil --float<CR>", { desc = "Open Oil (float)" })
map("n", "<leader>nd", ":OilCreateDir<CR>", { desc = "Oil: Create Directory " })
map("n", "<leader>nf>", ":OilCreateFile<CR>", { desc = "Oil: Create File" })
-- Noice
map("n", "<leader>nh", ":Noice history<CR>", { desc = "Noice: history" })
map("n", "<leader>nd", ":Noice dismiss<CR>", { desc = "Noice: dismiss" })

-- Misc
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- ------------------------------------------------------------
-- RUST KEYMAPS
-- ------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local m = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = buf, desc = "Rust: " .. desc })
        end
        m("<leader>rr", ":RustLsp run<CR>", "Run")
        m("<leader>rt", ":RustLsp testables<CR>", "Run Tests")
        m("<leader>re", ":RustLsp expandMacro<CR>", "Expand Macro")
        m("<leader>rc", ":RustLsp openCargo<CR>", "Open Cargo.toml")
        m("<leader>rd", ":RustLsp externalDocs<CR>", "Open Docs")
        m("<leader>rh", ":RustLsp hover actions<CR>", "Hover Actions")
    end,
})

-- ------------------------------------------------------------
-- GO KEYMAPS
-- ------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local m = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = buf, desc = "Go: " .. desc })
        end
        m("<leader>gt", ":GoTest<CR>", "Run Tests")
        m("<leader>gr", ":GoRun<CR>", "Run")
        m("<leader>gi", ":GoImports<CR>", "Organize Imports")
        m("<leader>gc", ":GoCoverage<CR>", "Coverage")
    end,
})
