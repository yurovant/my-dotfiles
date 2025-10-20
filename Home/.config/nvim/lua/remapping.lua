-- Disable arrow keys to force use of Vim motions
local disabled_keys = {"<Up>", "<Down>", "<Left>", "<Right>"}

-- Normal, Insert, Visual and Command-line modes
local modes = {"n", "i", "v", "c"}

for _, key in ipairs(disabled_keys) do
    -- The "" (empty string) as the right-hand side acts like <Nop>
    vim.keymap.set(modes, key, "")
end

-- ==================================================================
-- NORMAL and VISUAL modes
-- ==================================================================
-- "M" to jump to the beginning of the line (original "0" behavior)
vim.keymap.set({"n", "v"}, "M", "0")
-- "L" for jump to the end of the line (original "$" behavior)
vim.keymap.set({"n", "v"}, "L", "$")

-- ==================================================================
-- VISUAL and INSERT modes
-- ==================================================================
vim.keymap.set({"v", "i"}, "kj", "<Esc>")

-- ==================================================================
-- NORMAL mode
-- ==================================================================
-- 
-- left
vim.keymap.set("n", "m", "h")
-- down
vim.keymap.set("n", ",", "j")
-- "h" for marks instead of (original "m" behavior)
vim.keymap.set("n", "h", "m")
-- "j" for reverse t/T/f/F instead of (original "," behavior)
vim.keymap.set("n", "j", ",")

-- Center the screen when jumping
-- ==================================================================
-- Next search result
vim.keymap.set("n", "n", "nzzzv")
-- Previous search result
vim.keymap.set("n", "N", "Nzzzv")
-- Half page down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Half page up
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- ==================================================================
-- VISUAL mode
-- ==================================================================
-- left
vim.keymap.set("v", "m", "h")
-- down
vim.keymap.set("v", ",", "j")

-- ==================================================================
-- Issues to fix:

-- 1. You're missing the j → , remap in Visual mode
-- You have it in Normal mode but not Visual mode

-- 2. What happens to original M and L?
-- In default Vim:

-- M = Move to middle of screen
-- L = Move to lowest line on screen (with H for highest)
