vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex) -- Nvim file three
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)

-- Block Arrow Keys in Normal mode
vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")
