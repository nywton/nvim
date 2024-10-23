-- Treesitter configuration
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c",
    "css",
    "csv",
    "dockerfile",
    "elixir",
    "html",
    "javascript",
    "json",
    "lua",
    "go",
    "python",
    "query",
    "ruby",
    "scss",
    "typescript",
    "vim",
    "vimdoc"
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,              -- Enable Treesitter-based indentation
    disable = { "javascript" }, -- Disable Treesitter indent for JavaScript if needed
  },
}

-- Set tab and shift width for Go files
vim.cmd([[autocmd FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab]])

-- Set tab and shift width for Go template files
vim.cmd([[autocmd FileType tmpl,html setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab]])

-- Automatically format Go files on save
vim.cmd([[autocmd BufWritePre *.go silent! execute '!gofmt -w ' . expand('%:p')]])

-- Automatically format Go template files on save using gofmt
vim.cmd([[autocmd BufWritePre *.tmpl,*.tpl silent! execute '!gofmt -w ' . expand('%:p')]])

