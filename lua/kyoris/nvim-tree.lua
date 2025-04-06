-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
-- require("nvim-tree").setup()

require("nvim-tree").setup({
  -- sort = {
  --   sorter = "case_sensitive",
  -- },
  view = {
    width = 60,
    side = "right",
  },
  actions = {
    open_file = {
      quit_on_open = true, -- Closes nvim-tree after opening a file
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
})
