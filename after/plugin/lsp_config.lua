local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local cmp = require("cmp")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "denols", "html", "cssls", "tailwindcss" },
})

-- Configure nvim-cmp
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
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

-- Setup LSP servers with Mason-LSPConfig
mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })

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

        -- Format with <leader><leader>
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>', '',
          { callback = vim.lsp.buf.format, noremap = true, silent = true })
      end,
    })
  end,
})

lspconfig.denols.setup({
  on_attach = on_attach,
  cmd = { "deno", "lsp" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "tsx" },
  init_options = { enable = true, lint = true, unstable = true },
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
})


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
