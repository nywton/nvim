vim.g.mapleader = " "

-- command shortcut
vim.keymap.set('n', ';', ':', { noremap = true })

-- reloads the nvim config file
vim.keymap.set('n', '<Leader>rl', ':source $MYVIMRC<CR>', { silent = false })

-- nvim file three
vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>:q!<CR>")
--
--
-- disables arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")

-- move code using visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- centralize the document with zz on moving
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

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

local userprofile = os.getenv("USERPROFILE")
local nvim_config_dir = userprofile .. "/AppData/Local/nvim"

-- Change to the Neovim configuration directory and open the file
vim.keymap.set("n", "<leader>vpp", "<cmd>cd " .. nvim_config_dir .. " | e lua/kyoris/packer.lua<CR>")
vim.keymap.set("n", "<leader>km", "<cmd>cd " .. nvim_config_dir .. " | e lua/kyoris/remap.lua<CR>")


-- Panes shortcuts
vim.keymap.set('n', '<leader><Tab>', '<C-w>w', { noremap = true, silent = true })
-- Resize split panes using Ctrl + arrow keys
vim.keymap.set('n', '<C-Right>', '<C-w>>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', '<C-w><', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>', '<C-w>+', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', '<C-w>-', { noremap = true, silent = true })

-- Clear current suggestion	codeium#Clear()	<C-]>
-- Next suggestion	codeium#CycleCompletions(1)	<M-]>
-- Previous suggestion	codeium#CycleCompletions(-1)	<M-[>
-- Insert suggestion	codeium#Accept()	<Tab>
-- Manually trigger suggestion	codeium#Complete()	<M-Bslash>
-- Accept word from suggestion	codeium#AcceptNextWord()	<C-k>
-- Accept line from suggestion	codeium#AcceptNextLine()	<C-l>
--
-- https://github.com/Exafunction/codeium.vim?tab=readme-ov-file
vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#CycleCompletions'](1) end,
  { expr = true, silent = true })
vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
  { expr = true, silent = true })
vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
