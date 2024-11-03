local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local cmp = require("cmp")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "html", "cssls", "tailwindcss", "gopls", "ruby_lsp" },
})

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

        -- LSP keymaps
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
--

-- Setup for Standardrb Language Server
-- https://github.com/standardrb/standardrb
-- installs :
-- $ gem install standard
-- lspconfig.standardrb.setup({
--   on_attach = on_attach,
--   filetypes = { "ruby" },
--   cmd = { "~/.rbenv/shims/standardrb", "--lsp" },
-- })

-- Autocommand for Ruby filetype to ensure the signcolumn is set
-- vim.opt.signcolumn = "yes" -- Always show sign column
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "ruby",
--   group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }),
--   callback = function()
--     vim.lsp.start {
--       name = "standard",
--       cmd = { "~/.rbenv/shims/standardrb", "--lsp" },
--     }
--   end,
-- })

-- Configure nvim-cmp (auto-completion)
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-E>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})
