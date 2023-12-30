vim.g.mapleader = " "

-- reloads the nvim config file
vim.keymap.set('n', '<Leader><Leader>', ':source $MYVIMRC<CR>', { silent = false })

-- nvim file three
vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)

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

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/kyoris/packer.lua<CR>");
vim.keymap.set("n", "<leader>km", "<cmd>e ~/.config/nvim/lua/kyoris/remap.lua<CR>");


vim.keymap.set("n", "<leader>w", "<C-w>");
vim.keymap.set('n', '<leader><Tab>', '<C-w>w', { noremap = true, silent = true })

-- Git

vim.keymap.set("n", "<leader>gg", "<cmd>:Git<CR>");
vim.keymap.set("n", "<leader>t", "<cmd>:Telescope<CR>");
vim.keymap.set("n", "<leader>ggd", "<cmd>:Gvdiff<CR>");
