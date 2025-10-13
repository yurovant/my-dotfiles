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

-- NORMAL mode
-- left
vim.keymap.set('n', 'm', 'h', {
    noremap = true
})
-- down
vim.keymap.set('n', ',', 'j', {
    noremap = true
})
-- `h` for marks instead of `m`
vim.keymap.set('n', 'h', 'm', {
    noremap = true
})
-- `j` for reverse t/T/f/F instead of `,`
vim.keymap.set('n', 'j', ',', {
    noremap = true
})

-- VISUAL mode
-- left
vim.keymap.set('v', 'm', 'h', {
    noremap = true
})
-- down
vim.keymap.set('v', ',', 'j', {
    noremap = true
})
-- to exit this mode you need to type `v` again
-- OR press <Esc>
-- OR press `kj`
vim.keymap.set('v', 'kj', '<Esc>', {
    noremap = true
})

-- INSERT mode
-- combination of rare letter sequence 'kj' for English
vim.keymap.set('i', 'kj', '<Esc>', {
    noremap = true
})
