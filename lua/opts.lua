vim.opt.guicursor = ""

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w" , "<cmd>w<cr>", {desc="Save"})
vim.keymap.set("n", "<leader>q" , "<cmd>q<cr>", {desc="Quit"})
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], {desc="Copy to clipboard"})
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.cmd([[autocmd BufLeave * silent! wall]])

vim.opt.cursorline = true

vim.o.foldcolumn = '0'
