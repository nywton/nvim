require('telescope').setup {
  defaults = {
    -- ...
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    },
    git_file = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
    },
    help_tags = {
      theme = "dropdown",
    },
  },
  extensions = {
    -- ...
  }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>hh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>t", "<cmd>:Telescope<CR>");
