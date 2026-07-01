return {
  { "williamboman/mason.nvim", cmd = "Mason", opts = { ui = { border = "rounded" } } },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "gopls",
        "rust_analyzer",
        "ts_ls",
        "pyright",
        "bashls",
        "jsonls",
        "yamlls",
        "html",
        "cssls",
        "emmet_language_server",
        "tailwindcss",
        "eslint",
      },
      automatic_enable = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      vim.lsp.config("*", { capabilities = capabilities })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
            completion = { callSnippet = "Replace" },
            hint = {
              enable = true,
              arrayIndex = "Enable",
              await = true,
              paramName = "All",
              paramType = true,
              semicolon = "All",
              setType = true,
            },
          },
        },
      })

      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            analyses = { unusedparams = true, shadow = true },
            staticcheck = true,
            gofumpt = true,
            templateExtensions = { "tmpl", "gotmpl", "html" },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
            check = { command = "clippy" },
            inlayHints = {
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 10 },
              closureCaptureHints = { enable = true },
              closureReturnTypeHints = { enable = "always" },
              closureStyle = "impl_fn",
              discriminantHints = { enable = "always" },
              expressionAdjustmentHints = {
                enable = "always",
                hideOutsideUnsafe = false,
                mode = "prefix",
              },
              genericParameterHints = {
                lifetime = { enable = true },
                type = { enable = true },
                const = { enable = true },
              },
              implicitDrops = { enable = true },
              lifetimeElisionHints = {
                enable = "always",
                useParameterNames = true,
              },
              maxLength = 80,
              parameterHints = { enable = true },
              rangeExclusiveHints = { enable = true },
              reborrowHints = { enable = "always" },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
          },
        },
      })

      local ts_inlay_prefs = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
      vim.lsp.config("ts_ls", {
        settings = {
          typescript = { inlayHints = ts_inlay_prefs },
          javascript = { inlayHints = ts_inlay_prefs },
        },
      })

      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              inlayHints = {
                functionReturnTypes = true,
                variableTypes = true,
                callArgumentNames = true,
                genericTypes = true,
              },
            },
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          local function map(k, f, desc)
            vim.keymap.set("n", k, f, { buffer = bufnr, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Goto definition")
          map("gD", vim.lsp.buf.declaration, "Goto declaration")
          map("gr", vim.lsp.buf.references, "References")
          map("gi", vim.lsp.buf.implementation, "Implementation")
          map("gy", vim.lsp.buf.type_definition, "Type definition")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>lr", "<cmd>LspRestart<CR>", "Restart LSP")
          map("<leader>ih", function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
              { bufnr = bufnr }
            )
          end, "Toggle inlay hints")
        end,
      })

      vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#5c6370", italic = true })

      vim.diagnostic.config({
        virtual_text = false,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
          },
        },
      })
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        options = {
          show_source = true,
          multilines = { enabled = true },
          break_line = { enabled = true, after = 80 },
        },
      })
    end,
  },
}
