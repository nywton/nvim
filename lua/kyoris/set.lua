vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

local undo_path = os.getenv("USERPROFILE") .. "/AppData/Local/nvim/undo"

if vim.fn.isdirectory(undo_path) == 0 then
  vim.fn.mkdir(undo_path, "p", 0700)
end

vim.o.undodir = undo_path
vim.o.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50


-- vim.opt.colorcolumn = "80"

vim.opt.termguicolors = true
