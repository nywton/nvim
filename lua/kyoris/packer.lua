-- Only required if you have packer configured as `opt`

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use('m4xshen/autoclose.nvim')
  -- nvium status
  -- use 'vim-airline/vim-airline'
  -- use 'vim-airline/vim-airline-themes'

  -- use 'tpope/vim-rails'

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

  use 'nvim-tree/nvim-web-devicons'

  use('nvim-tree/nvim-tree.lua')

  -- https://github.com/lukas-reineke/indent-blankline.nvim
  -- Visual markup for scopes
  use("lukas-reineke/indent-blankline.nvim")

  use('theprimeagen/harpoon')

  use('mbbill/undotree')

  use('tpope/vim-fugitive')
  use('lewis6991/gitsigns.nvim')

  -- LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  use 'ryanoasis/vim-devicons'

  -- LSP completions
  use {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip'
  }

  -- Hash Colors
  use { 'brenoprata10/nvim-highlight-colors' }


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

  -- Copilot alternative
  -- Usage: :Codeium Auth or :help codemium
  -- Remove the `use` here if you're using folke/lazy.nvim.
  -- https://github.com/Exafunction/codeium.vim?tab=readme-ov-file
  -- use {
  --   'Exafunction/codeium.vim',
  --   config = function()
  --     -- vim.g.codeium_disable_bindings = 0
  --     vim.vim.g.codeium_no_map_tab = 1
  --     -- Change '<C-g>' here to any keycode you like.
  --     -- vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
  --     -- vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
  --     --   { expr = true, silent = true })
  --     -- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
  --     --   { expr = true, silent = true })
  --     -- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  --   end
  -- }
end)

