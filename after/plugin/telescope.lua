require('telescope').setup {
  file_ignore_patterns = { "node_modules" },
  defaults = {
    layout_config = {
      width = 0.95,  -- Set the width to 90% of the available space
      height = 0.95, -- Set the height to 90% of the available space
      preview_width = 0.55,
    }
  },
  pickers = {
    -- find_files = {
    --   theme = "dropdown",
    -- },
    -- live_grep = {
    --   theme = "dropdown",
    -- },
    -- git_file = {
    --   theme = "dropdown",
    -- },
    -- buffers = {
    --   theme = "dropdown",
    -- },
    -- help_tags = {
    --   theme = "dropdown",
    -- },
  },
  extensions = {
    -- ...
  }
}

local builtin = require('telescope.builtin')

local actions = require "telescope.actions"
local state = require "telescope.state"

local last_find_files = nil

local function find_files(opts)
  opts = opts or {}
  if last_find_files == nil then
    require "telescope.builtin".find_files {
      attach_mappings = function(prompt_bufnr, map)
        actions.close:enhance {
          post = function()
            -- taken from builtin.resume maybe rfc into a `telescope.utils`.get_last_picker
            local cached_pickers = state.get_global_key "cached_pickers"
            if cached_pickers == nil or vim.tbl_isempty(cached_pickers) then
              print "No picker(s) cached"
              return
            end
            last_find_files = cached_pickers[1] -- last picker is always 1st
          end
        }
        return true
      end
    }
  else
    require "telescope.builtin".resume { picker = last_find_files }
  end
end

vim.keymap.set('n', '<leader>f', find_files, {})
vim.keymap.set('v', '<leader>f', 'y<ESC>:Telescope find_files default_text=<c-r>0<CR>', default_opts)
vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
vim.keymap.set('v', '<leader>s', 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>', default_opts)
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>hh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>t", "<cmd>:Telescope<CR>");
