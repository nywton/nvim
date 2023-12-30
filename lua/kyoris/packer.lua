-- Only required if you have packer configured as `opt`

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  use 'tpope/vim-rails'

  -- Theme color scheme
  -- use({ 'rose-pine/neovim', as = 'rose-pine' })

  use { "catppuccin/nvim", as = "catppuccin" }

  -- https://github.com/nvim-lualine/lualine.nvim
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- https://github.com/nvim-tree/nvim-tree.lua
  use('nvim-tree/nvim-tree.lua')
  use('nvim-tree/nvim-web-devicons')

  use('theprimeagen/harpoon')

  use('mbbill/undotree')

  use('tpope/vim-fugitive')
  use('lewis6991/gitsigns.nvim')

  use { 'mihyaeru21/nvim-lspconfig-bundler', requires = 'neovim/nvim-lspconfig' }

  -- Lua
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  }

  -- Lua
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
end)
