local opt = vim.opt

-- Lines
opt.number = true                -- Display absolute line numbers
opt.relativenumber = true        -- Show line numbers relative to cursor position
opt.numberwidth = 2              -- Width of the line number column
opt.cursorline = true            -- Highlight the current line
opt.scrolloff = 10               -- Keep 10 lines visible above/below cursor when scrolling

-- Indentation
opt.tabstop = 2                  -- Display tab characters as 2 spaces wide
opt.shiftwidth = 2               -- Use 2 spaces for automatic indentation (>>, <<, etc.)
opt.softtabstop = 2              -- Treat 2 spaces as a tab unit when editing
opt.expandtab = true             -- Insert spaces instead of tab characters
opt.smartindent = true           -- Automatically indent after opening braces
opt.autoindent = true            -- Copy indentation from previous line

-- Search
opt.ignorecase = true            -- Search is case-insensitive by default
opt.smartcase = true             -- Override ignorecase if search contains uppercase letters
opt.incsearch = true             -- Highlight matches as you type the search pattern

-- don't highlight search results (why?)
-- opt.hlsearch = false

-- Visual settings
opt.termguicolors = true         -- Enable true color (24-bit RGB) support for vibrant colors
opt.signcolumn = "yes"           -- Always show the sign column for git/diagnostic indicators
opt.showmatch = true             -- Briefly highlight matching brackets when cursor is on one
opt.matchtime = 2                -- Duration (in tenths of a second) to highlight matching brackets
opt.cmdheight = 1                -- Height of the command line at the bottom
opt.updatetime = 50              -- Milliseconds before swap file is written and CursorHold fires

-- File handling
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
opt.autoread = true

-- Clipboard
opt.clipboard = "unnamedplus"
