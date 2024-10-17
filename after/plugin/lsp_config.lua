local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "denols", "html", "cssls", "tailwindcss" },
})

local on_attach = function(client, bufnr)
  -- Format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })

  -- Key mappings for LSP commands
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader><leader>", vim.lsp.buf.format, opts) -- Manual format

  -- Global key mappings
  local global_opts = { noremap = true, silent = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, global_opts)           -- Go to definition
  vim.keymap.set("n", "gr", vim.lsp.buf.references, global_opts)           -- Show references
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, global_opts)       -- Go to implementation
  vim.keymap.set("n", "K", vim.lsp.buf.hover, global_opts)                 -- Hover documentation
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, global_opts)       -- Rename symbol
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, global_opts)  -- Code actions
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, global_opts)         -- Go to previous diagnostic
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, global_opts)         -- Go to next diagnostic
  vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float, global_opts) -- Show diagnostic popup
  vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, global_opts) -- Set location list
end

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = vim.lsp.protocol.make_client_capabilities(),
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
