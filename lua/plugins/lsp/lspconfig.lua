local plugins = {}

if not vim.g.vscode then

  local base = require("plugins.lsp.base")
  local mason = require("plugins.lsp.mason")
  local linter = require("plugins.lsp.linter")
  local formatter = require("plugins.lsp.formatter")
  local extra = require("plugins.lsp.extra")

  local function lsp_attach_keymap(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local opts = { buffer = ev.buf }

    if client and client:supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.declaration,
        vim.tbl_deep_extend("force", opts, { desc = "Jumps to the declaration of the symbol under the cursor" }))
    end

    if client and client:supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
        vim.tbl_deep_extend("force", opts, { desc = "Jumps to the declaration of the symbol under the cursor" }))
    end
  end

  plugins = {
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "hrsh7th/nvim-cmp",
        "williamboman/mason-lspconfig.nvim",
      },
      ft = base.fts,
      init = function()
        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "List all diagnostics" })
      end,
      opts = {
        inlay_hints = {
          enable = true
        },
        codelens = {
          enable = true
        }
      },
      config = function(_, opts)
        local have_mason, mlsp = pcall(require, "mason-lspconfig")

        local function inlay_hints(buf, value)
          local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
          if type(ih) == "function" then
            ih(buf, value)
          elseif type(ih) == "table" and ih.enable then
            if value == nil then
              value = not ih.is_enabled(buf)
            end
            ih.enable(buf, value)
          end
        end

        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          has_cmp and cmp_nvim_lsp.default_capabilities() or {},
          opts.capabilities or {}
        )
        local function setup(server)
          local server_opts = vim.tbl_deep_extend("force", {
            capabilities = vim.deepcopy(capabilities),
          }, base.ls_opts[server] or {})

          if mason.lsp_handlers[server] then
            if mason.lsp_handlers[server](server, server_opts) then
              return
            end
          elseif mason.lsp_handlers["*"] then
            if mason.lsp_handlers["*"](server, server_opts) then
              return
            end
          end
          require("lspconfig")[server].setup(server_opts)
        end

        for _, server in pairs(base.language_servers) do
          if not vim.tbl_contains(mason.lsp_ensured_list, server) and
              have_mason and
              not vim.tbl_contains(mlsp.get_installed_servers(), server) then
            setup(server)
          end
        end

        if have_mason then
          mlsp.setup({
            ensure_installed = mason.lsp_ensured_list,
            automatic_installation = false
          })
          mlsp.setup_handlers({setup})
        end

        -- inlay hints
        if opts.inlay_hints.enabled then
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local buffer = args.buf
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client ~= nil and client:supports_method("textDocument/inlayHint") then
                  inlay_hints(buffer, true)
              end
            end,
          })
        end

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspConfig", {}),
          callback = lsp_attach_keymap,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("LspFoldExpr", {}),
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client ~= nil and client:supports_method('textDocument/foldingRange') then
              local win = vim.api.nvim_get_current_win()
              vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
            end
          end
        })
      end,
    }
  }
  plugins = vim.list_extend(
    vim.list_extend(
      vim.list_extend(
        vim.list_extend(
          plugins,
          mason.plugins),
        linter.plugins),
      formatter.plugins),
    extra.plugins)
end

return plugins
