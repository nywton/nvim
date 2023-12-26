vim.opt.signcolumn = 'yes'

local lsp = require('lsp-zero').preset("recommended")
local lspconfig = require('lspconfig')

-- list of available servers on :help lspconfig-all
lsp.ensure_installed({
  'html',
  'cssls',
  'tsserver',
  'eslint',
  'tailwindcss',
  -- 'solargraph'
})

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

-- Ruby LSP Setup
-- require('lspconfig-bundler').setup()
--
-- lspconfig.ruby_ls.setup({
--   cmd = { "bundle", "exec", "ruby-lsp" }
-- })

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
    { desc = '[G]o to [d]efinition', buffer = bufnr, remap = false })
  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end,
    { desc = '[G]o to [D]eclaration', buffer = bufnr, remap = false })
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end,
    { desc = '[G]o to [R]eferences (with LSP)', buffer = bufnr, remap = false })
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end,
    { desc = '[G]o to [I]mplementation (with LSP)', buffer = bufnr, remap = false })
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = '[K] Hover info', buffer = bufnr, remap = false })
  vim.keymap.set("n", "R", function() vim.lsp.buf.rename() end,
    { desc = '[R]ename symbol (with LSP)', buffer = bufnr, remap = false })

  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>[d", function() vim.diagnostic.go_next() end, opts)
  vim.keymap.set("n", "<leader>]d", function() vim.diagnostic.go_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  -- vim.keymap.set('i', '<Tab>', '<C-x><C-o>', { noremap = true, silent = true }) -- make Tab to accept lsp sugestion


  lsp.default_keymaps({ buffer = bufnr })
end)

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['solargraph'].setup { capabilities = capabilities }
require('lspconfig')['html'].setup { capabilities = capabilities }
require('lspconfig')['cssls'].setup { capabilities = capabilities }
require('lspconfig')['tsserver'].setup { capabilities = capabilities }
require('lspconfig')['eslint'].setup { capabilities = capabilities }
require('lspconfig')['tailwindcss'].setup {}

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = { 'tsserver', 'rust_analyzer' },
  handlers = {
    lsp.default_setup,
  },
})


-- textDocument/diagnostic support until 0.10.0 is released
lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    -- ['solargraph'] = { 'ruby' },
    ['html'] = { 'html' }
  }
})

lsp.setup()

local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }
})
