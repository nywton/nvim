local lsp = require('lsp-zero').preset("recommended")

lsp.ensure_installed({
	'tsserver',
	'eslint',
	-- 'sumneko_lua'
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require'lspconfig'.ruby_ls.setup{}

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

if not configs.ruby_lsp then
	local enabled_features = {
		"documentHighlights",
		"documentSymbols",
		"foldingRanges",
		"selectionRanges",
		"semanticHighlighting",
		"formatting",
		"codeActions",
	}

	configs.ruby_lsp = {
		default_config = {
			cmd = { "bundle", "exec", "ruby-lsp" },
			filetypes = { "ruby" },
			root_dir = util.root_pattern("Gemfile", ".git"),
			init_options = {
				enabledFeatures = enabled_features,
			},
			settings = {},
		},
		commands = {
			FormatRuby = {
				function()
					vim.lsp.buf.format({
						name = "ruby_lsp",
						async = true,
					})
				end,
				description = "Format using ruby-lsp",
			},
		},
	}
end

lspconfig.ruby_lsp.setup({ on_attach = on_attach, capabilities = capabilities })

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()
