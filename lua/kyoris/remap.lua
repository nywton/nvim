vim.g.mapleader = " "

-- command shortcut
vim.keymap.set('n', ';', ':', { noremap = true })

-- reloads the nvim config file
vim.keymap.set('n', '<Leader>rl', ':source $MYVIMRC<CR>', { silent = false })

-- nvim file three
vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>:w!<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>:q!<CR>")
--
--
-- disables arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")

-- Center cursor on jump back and forward
vim.keymap.set("n", "<C-o>", "<C-o>zz") -- Go back in jump list and center
vim.keymap.set("n", "<C-i>", "<C-i>zz") -- Go forward in jump list and center

-- move code using visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- centralize the document with zz on moving
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "G", "m`Gzz")

-- remap leader p to void register (does not replace the previous yank)
vim.keymap.set("x", "<leader>p", "\"_dP")

-- remap system clipboard interactions
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", "\"+yg_")
vim.keymap.set("n", "<leader>d", "\"+yg_")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

-- moving in the document
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "*", "*zz")


-- refactor object
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/kyoris/packer.lua<CR>");
vim.keymap.set("n", "<leader>km", "<cmd>e ~/.config/nvim/lua/kyoris/remap.lua<CR>");


-- Panes shortcuts
vim.keymap.set('n', '<leader><Tab>', '<C-w>w', { noremap = true, silent = true })
-- Resize split panes using Ctrl + arrow keys
vim.keymap.set('n', '<C-Right>', '<C-w>>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', '<C-w><', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>', '<C-w>+', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', '<C-w>-', { noremap = true, silent = true })

-- Copilot
-- vim.keymap.set('i', '<C-Space>', '<Plug>(copilot-accept-word)')
-- vim.keymap.set('i', '<C-Enter>', '<Plug>(copilot-accept-line)')
-- vim.keymap.set('i', '<C-l>', '<Plug>(copilot-next)', { noremap = false })
--

-- runs mix format on current file
vim.keymap.set("n", "<leader>mf", "<cmd>silent! !mix format %<CR>")

-- Autocommand to run `mix format` on save for .ex, .exs, .heex files
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ex", "*.exs", "*.heex" },
  command = "silent! !mix format %",
})


-- Copy file name
-- <leader>cf: Copy file name
-- <leader>cl: Copy absolute path
--
-- Copy file path to clipboard in different formats based on OS
if vim.loop.os_uname().sysname == "Windows_NT" then
  -- Copy relative path with backslashes
  vim.keymap.set("n", "<leader>cs", function()
    vim.fn.setreg("+", vim.fn.expand("%"):gsub("/", "\\"))
  end, { desc = "Copy relative file path with \\" })

  -- Copy absolute path with backslashes
  vim.keymap.set("n", "<leader>cl", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"):gsub("/", "\\"))
  end, { desc = "Copy absolute file path with \\" })

  -- Copy 8.3 DOS short format with backslashes
  vim.keymap.set("n", "<leader>c8", function()
    vim.fn.setreg("+", vim.fn.expand("%:p:8"):gsub("/", "\\"))
  end, { desc = "Copy 8.3 DOS file path with \\" })
else
  -- Non-Windows: use normal path
  vim.keymap.set("n", "<leader>cs", function()
    vim.fn.setreg("+", vim.fn.expand("%"))
  end, { desc = "Copy relative file path" })

  vim.keymap.set("n", "<leader>cl", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
  end, { desc = "Copy absolute file path" })
end
