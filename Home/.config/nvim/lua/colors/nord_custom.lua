local M = {}

M.setup = function()
    local colors = {
        nord0 = "#2E3440", -- Darkest background
        nord1 = "#3B4252",
        nord2 = "#434C5E",
        nord3 = "#4C566A", -- Lighter background
        nord4 = "#D8DEE9", -- Light text
        nord5 = "#E5E9F0",
        nord6 = "#ECEFF4", -- Lightest text
        nord7 = "#8FBCBB", -- Aurora green
        nord8 = "#88C0D0", -- Aurora cyan
        nord9 = "#81A1C1", -- Aurora blue
        nord10 = "#5E81AC", -- Aurora darker blue
        nord11 = "#BF616A", -- Aurora red
        nord12 = "#D08770", -- Aurora orange
        nord13 = "#EBCB8B", -- Aurora yellow
        nord14 = "#A3BE8C", -- Aurora green (alt)
        nord15 = "#B48EAD" -- Aurora purple
    }

    vim.o.background = "dark"
    vim.cmd("highlight clear")
    vim.cmd("syntax reset")

    -- Set general Neovim highlights
    vim.api.nvim_set_hl(0, "Normal", {
        fg = colors.nord4,
        bg = colors.nord0
    })
    vim.api.nvim_set_hl(0, "Comment", {
        fg = colors.nord3,
        italic = true
    })

    -- Add more highlight groups as needed, e.g., for keywords, strings, etc.
    -- vim.api.nvim_set_hl(0, "Keyword", { fg = colors.nord9 })
    -- vim.api.nvim_set_hl(0, "String", { fg = colors.nord14 })
end

return M
