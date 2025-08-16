local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local util = require("lspconfig.util")

-- ===============================
-- Diagnostics: inline + popup
-- ===============================
-- Faster CursorHold so the popup shows quickly
vim.o.updatetime = 250

-- Always-on inline diagnostics at end of the line + useful float defaults
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- e.g. "■", "▶", "❯"
    source = "if_many", -- show source if multiple
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    focusable = false,
    scope = "line", -- show diagnostics for the current line
  },
})

-- Auto-open diagnostic float when cursor stops on a line with diagnostics
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    -- Only open if there are diagnostics under cursor
    local diags = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
    if #diags > 0 then
      vim.diagnostic.open_float(nil, { focus = false })
    end
  end,
})

-- ===============================
-- Mason setup
-- ===============================

-- Setup Mason
mason.setup()

-- Ensure common LSPs are installed
mason_lspconfig.setup({
  ensure_installed = {
    "html",
    "cssls",
    "tailwindcss",
    -- "gopls",
    "ruby_lsp",
    -- "ts_ls",
    "denols",
  },
})

-- Common capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- on_attach: common keymaps + format on save
local function on_attach(client, bufnr)
  local bufmap = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
  end

  -- Format before save if supported
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  -- LSP keymaps
  bufmap("n", "gd", vim.lsp.buf.definition)
  bufmap("n", "gr", vim.lsp.buf.references)
  bufmap("n", "gi", vim.lsp.buf.implementation)
  bufmap("n", "K", vim.lsp.buf.hover)
  bufmap("n", "<leader>rn", vim.lsp.buf.rename)
  bufmap("n", "<leader>ca", vim.lsp.buf.code_action)
  bufmap("n", "<leader>cb", vim.lsp.buf.format)
  bufmap("n", "[d", vim.diagnostic.goto_prev)
  bufmap("n", "]d", vim.diagnostic.goto_next)
  bufmap("n", "<leader>E", vim.diagnostic.open_float)
  bufmap("n", "<leader>Q", vim.diagnostic.setloclist)
end

-- Helpers for project detection
local is_node = function(root_dir)
  return util.root_pattern("package.json")(root_dir)
      and not util.root_pattern("deno.json", "deno.jsonc")(root_dir)
end

local is_deno = function(root_dir)
  return util.root_pattern("deno.json", "deno.jsonc")(root_dir)
end

-- ts_ls (Node)
-- lspconfig.ts_ls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   root_dir = function(fname)
--     if is_node(fname) then
--       return util.root_pattern("package.json")(fname)
--     end
--   end,
-- })

-- denols (Deno)
lspconfig.denols.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function(fname)
    if is_deno(fname) then
      return util.root_pattern("deno.json", "deno.jsonc")(fname)
    end
  end,
  init_options = {
    enable = true,
    lint = true,
    unstable = true,
  },
})

-- HTML
lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmx" },
})

-- CSS
lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "css", "scss", "less" },
})

-- TailwindCSS
lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Ruby LSP
lspconfig.ruby_lsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "ruby" },
  init_options = { formatter = "auto" },
  settings = {
    rubocop = {
      command = "rubocop",
      args = { "--format", "json" },
    },
  },
})

-- Go
-- lspconfig.gopls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })

-- Optional: global fallback autoformat (e.g. in TypeScript files)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.js", "*.tsx", "*.jsx", "*.json", "*.css", "*.scss", "*.html", "*.md", "*.lua" },
  callback = function()
    vim.lsp.buf.format()
  end,
})
