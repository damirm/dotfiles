vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Copy indent from current line
vim.opt.tabstop = 4
vim.opt.copyindent = true
vim.opt.wrap = false
vim.opt.grepprg = "rg --vimgrep" -- Use ripgrep if available
vim.opt.grepformat = "%f:%l:%c:%m" -- filename, line number, column, content
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true -- Show matches as you type
vim.opt.ignorecase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.autoread = true
vim.opt.cursorline = true
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.colorcolumn = "120"
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.spelllang = { "en", "ru" } -- Set language for spellchecking
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.undofile = true
-- vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.filetype.add({
	extension = {
		j2 = "jinja",
	},
})
