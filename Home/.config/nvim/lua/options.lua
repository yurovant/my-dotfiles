local opt = vim.opt

-- Line numbers
-- show line numbers
opt.number = true
-- show relative line numbers
opt.relativenumber = true
-- keep the numbers column narrow
opt.numberwidth = 2
-- highlight current line
opt.cursorline = true
-- keep 10 lines above / below the cursor
opt.scrolloff = 10
opt.sidescrolloff = 8
-- keep 8 columns left / right of the cursor (wut?)

-- wrap the lines (true is default)
-- opt.wrap = false

-- Indentation
-- tab width
opt.tabstop = 2
-- indent width
opt.shiftwidth = 2
-- soft tab stop (wut?)
opt.softtabstop = 2
-- use spaces instead of tabs
opt.expandtab = true
-- smart auto-indentation
opt.smartindent = true
-- copy indentation from current line
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- don't highlight search results (why?)
-- opt.hlsearch = false

-- UI
-- opt.termguicolors = true
-- always show sign column (wut?)
opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.showmatch = true
opt.matchtime = 2
-- opt.updatetime = 50

-- File handling
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
opt.autoread = true

-- Clipboard
opt.clipboard = "unnamedplus"
