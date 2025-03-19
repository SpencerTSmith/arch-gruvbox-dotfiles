vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true
vim.g.c_syntax_for_h = true

vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.breakindent = true

-- Header files have nicer indent patterns
vim.o.cinoptions = ":0,(0,w1,m1"

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"

-- Line numbers and such
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.scrolloff = 10
vim.o.cursorline = true

vim.o.syntax = "enable"

-- Decrease update time
vim.o.updatetime = 200

vim.o.list = true
vim.opt.listchars = { tab = "  ", extends = "…", precedes = "…", trail = "·", nbsp = "␣" }
vim.opt.showbreak = "↪"

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

-- status line does it
vim.o.showmode = false
vim.o.ruler = false
vim.o.cmdheight = 1

-- Preview substitutions live, as you type!
vim.o.incsearch = true

vim.o.undofile = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.confirm = true

-- Sync up default register with system clipboard
vim.o.clipboard = "unnamedplus"

vim.o.linebreak = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.infercase = true

vim.o.virtualedit = "block,onemore"

vim.opt.shortmess:append("aWCI")

-- vim.o.pumblend = 10
-- vim.o.winblend = 10
vim.o.pumheight = 10

vim.o.hlsearch = true
