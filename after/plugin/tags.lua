-- (Exuberant/Universal) Ctags
vim.opt.tags = '.tags'

function RTags()
  -- run on the root of the project to generate ctags. Add tags folder to .gitignore
  -- vim.cmd [[!ctags -f .tags --languages=ruby --exclude=.git -R .]]
  vim.cmd [[!ctags -R --languages=ruby --exclude=.git --exclude=log --exclude=tmp . $(bundle list --paths)]]
end

vim.keymap.set("n", "rT", RTags)
