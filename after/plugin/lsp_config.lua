local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  lsp.default_keymaps({ buffer = bufnr })
  vim.keymap.set('n', '<leader><leader>', vim.lsp.buf.format)
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp.default_setup,

    -- Install lsp gem by running:
    -- $ gem install ruby-lsp
    ruby_ls = function()
      require('lspconfig').ruby_ls.setup({
        cmd = { "bundle", "exec", "ruby-lsp" }
      })
    end,

    lua_ls = function()
      require('lspconfig').lua_ls.setup {
        on_attach = on_attach
      }
    end,
  },
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = {
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item({ behavior = 'insert' })
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({ behavior = 'insert' })
      else
        cmp.complete()
      end
    end),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})


-- -- Keybinds
-- local on_attach = function(_, bufnr)
--   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
--   vim.keymap.set('n', 'gt', vim.lsp.buf.implementation, {})
--   vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
--   vim.keymap.set('n', '<space><space>', function()
--     vim.lsp.buf.format { async = true }
--   end, opts)
-- end
--
--
