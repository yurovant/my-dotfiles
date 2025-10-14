-- Disable arrow keys to force use of Vim motions
local disabled_keys = {"<Up>", "<Down>", "<Left>", "<Right>"}

-- Normal, Insert, Visual, Command-line modes
local modes = {"n", "i", "v", "c"}

for _, key in ipairs(disabled_keys) do
    -- The "" (empty string) as the right-hand side acts like <Nop>
    vim.keymap.set(modes, key, "", {
        noremap = true
    })
end

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- NORMAL and VISUAL modes
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- "M" to jump to the beginning of the line (original "0" behavior)
vim.keymap.set({"n", "v"}, "M", "0", {
    noremap = true
})

-- "L" for jump to the end of the line (original "$" behavior)
vim.keymap.set({"n", "v"}, "L", "$", {
    noremap = true
})

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- VISUAL and INSERT modes
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vim.keymap.set({"v", "i"}, "kj", "<Esc>", {
    noremap = true
})

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- NORMAL mode
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- left
vim.keymap.set("n", "m", "h", {
    noremap = true
})

-- down
vim.keymap.set("n", ",", "j", {
    noremap = true
})

-- "h" for marks instead of (original "m" behavior)
vim.keymap.set("n", "h", "m", {
    noremap = true
})

-- "j" for reverse t/T/f/F instead of (original "," behavior)
vim.keymap.set("n", "j", ",", {
    noremap = true
})

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- VISUAL mode
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- left
vim.keymap.set("v", "m", "h", {
    noremap = true
})

-- down
vim.keymap.set("v", ",", "j", {
    noremap = true
})

-- Issues to fix:

-- 1. You're missing the j → , remap in Visual mode
-- You have it in Normal mode but not Visual mode

-- 2. What happens to original M and L?
-- In default Vim:

-- M = Move to middle of screen
-- L = Move to lowest line on screen (with H for highest)
