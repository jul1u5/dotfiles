vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

vim.o.cmdheight = 0
vim.o.laststatus = 3
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.updatetime = 100
vim.o.foldenable = false
vim.o.scrolloff = 999
vim.o.mouse = "a"
-- vim.o.tabstop = 4
-- vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.timeoutlen = 400
vim.o.pumheight = 10

vim.opt.rnu = true
vim.opt.ignorecase = true
vim.opt.signcolumn = "yes"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
