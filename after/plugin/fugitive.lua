-- Git

local map = vim.keymap.set

map("n", "<leader>gg", "<cmd>:Git<CR>");
map("n", "<leader>gb", "<cmd>:Git blame<CR>");
map("n", "<leader>gl", "<cmd>:Git log<CR>");

-- Git Workflow
map("n", "<leader>gs", "<cmd>Git status<CR>", { desc = "Git status" })
map("n", "<leader>gp", "<cmd>git push<cr>", { desc = "git push" })
map("n", "<leader>gp", "<cmd>git pull<cr>", { desc = "git pull" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
map("n", "<leader>gC", "<cmd>Git commit --amend<CR>", { desc = "Amend last commit" })
map("n", "<leader>gA", "<cmd>Git add %<CR>", { desc = "Git add current file" })
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
map("n", "<leader>gd", "<cmd>Gvdiffsplit!<CR>", { desc = "Vertical diff of conflicts" })
