-- Git

local map = vim.keymap.set

-- map("n", "<leader>gg", "<cmd>:Git<CR>");
-- Open Fugitive Fullscreen
map("n", "<leader>gg", "<cmd>0Git<CR>", { desc = "Open Fugitive in fullscreen buffer" })
-- Open Fugitive in new tab
map("n", "<leader>gg", "<cmd>tab Git<CR>", { desc = "Open Fugitive in new tab (fullscreen)" })


map("n", "<leader>gb", "<cmd>:Git blame<CR>");
map("n", "<leader>gl", "<cmd>:Git log<CR>");

-- Git Workflow
-- map("n", "<leader>gs", "<cmd>Git status<CR>", { desc = "Git status" })
map("n", "<leader>gP", "<cmd>git push<cr>", { desc = "git push" })
map("n", "<leader>gp", "<cmd>git pull<cr>", { desc = "git pull" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
map("n", "<leader>gC", "<cmd>Git commit --amend<CR>", { desc = "Amend last commit" })
map("n", "<leader>ga", "<cmd>Git add %<CR>", { desc = "Git add current file" })
map("n", "<leader>gu", "<cmd>Git restore %<CR>", { desc = "Discard changes in current file" })
map("n", "<leader>gU", "<cmd>Git reset HEAD %<CR>", { desc = "Unstage current file" })
map("n", "<leader>gF", "<cmd>Git fetch<CR>", { desc = "Git fetch" })

-- File / Buffer navigation
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Merge-conflict helpers (Fugitive & built-in diffget)
map("n", "<leader>g1", "<cmd>diffget //2<CR>", { desc = "Use our version (diffget //2)" })
map("n", "<leader>g2", "<cmd>diffget //3<CR>", { desc = "Use their version (diffget //3)" })
map("n", "<leader>gr", "<cmd>Git mergetool<CR>", { desc = "Run Git mergetool" })
map("n", "<leader>gD", "<cmd>Gvdiffsplit!<CR>", { desc = "Vertical diff of conflicts" })
