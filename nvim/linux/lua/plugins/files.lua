return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeFocus" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      hijack_directories = { enable = true, auto_open = true },
      view = { width = 35, side = "left" },
      renderer = {
        group_empty = true,
        icons = {
          show = { file = true, folder = true, folder_arrow = true, git = true },
        },
      },
      filters = { dotfiles = false },
      git = { enable = true, ignore = false },
      actions = { open_file = { quit_on_open = false } },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        -- Apply nvim-tree's DEFAULT mappings first (<CR>=open, o, a, d, r, <Tab>,
        -- …). A custom on_attach replaces the defaults entirely, so without this
        -- call <CR> falls back to plain Vim (move down) instead of opening a file.
        api.config.mappings.default_on_attach(bufnr)
        local function opts_fn(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
        end
        vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts_fn("Open: Vertical Split"))
        vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts_fn("Open: Horizontal Split"))
        vim.keymap.set("n", "<C-t>", api.node.open.tab, opts_fn("Open: New Tab"))
      end,
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
            require("nvim-tree.api").tree.open()
          end
        end,
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent dir (oil)" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view_options = { show_hidden = true },
      float = { border = "rounded" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Doc symbols" },
      { "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace symbols" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "Commands" },
      { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    },
    opts = {
      defaults = {
        prompt_prefix = "  ",
        selection_caret = " ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          width = 0.87,
          height = 0.80,
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
