local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "html", "cssls", "tailwindcss", "gopls", "ruby_lsp", "nextls" },
})

-- Capabilities for enhanced LSP completion
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Setup LSP servers with Mason-LSPConfig
mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Format on save only if the server supports formatting
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end

        -- Automatic hover documentation when available
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, opts)

        -- Format with <leader><leader> if the server supports formatting
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>', '',
            { callback = vim.lsp.buf.format, noremap = true, silent = true })
        end
      end,
    })
  end,
})

-- lspconfig.denols.setup({
--   on_attach = on_attach,
--   cmd = { "deno", "lsp" },
--   filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "tsx" },
--   init_options = { enable = true, lint = true, unstable = true },
--   root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
-- })

-- Setup for CSS Language Server
lspconfig.cssls.setup({
  on_attach = on_attach,
  filetypes = { "css", "scss", "less" },
})

-- Setup for HTML Language Server
lspconfig.html.setup({
  on_attach = on_attach,
  filetypes = { "html", "htmx" },
})

-- Setup for Ruby Language Server
-- adds :gem install ruby-lsp to Gemfile of project
-- group :development do
--   gem "ruby-lsp", require: false
-- end
lspconfig.ruby_lsp.setup({
  on_attach = on_attach,
  filetypes = { "ruby" },
  init_options = {
    formatter = 'auto',
  },
  single_file_support = true,
  settings = {
    rubocop = {
      command = 'rubocop',           -- Command to run RuboCop
      args = { '--format', 'json' }, -- Additional arguments for RuboCop
      -- Include any other RuboCop settings as needed
    },
  },
})

lspconfig.nextls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "heex", "eex" },
  cmd = { "nextls", "--stdio" },
  init_options = {
    extensions = {
      credo = { enable = true }
    },
    experimental = {
      completions = { enable = false }
    }
  }
})

-- lspconfig.elixirls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     elixirLS = {
--       dialyzerEnabled = true,
--       fetchDeps = true,
--     },
--   },
--   filetypes = { "elixir" },
--   cmd = { " ~/.local/share/nvim/mason/bin/elixir-ls" },
-- })
--
