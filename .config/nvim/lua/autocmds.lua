local key = vim.keymap

-- Blank Line Functions
local function blank_line(direction)
    local count = vim.v.count1
    local line = direction == "up" and "put!" or "put"
    vim.cmd(string.format('%s =repeat(nr2char(10), %d)', line, count))
    vim.cmd(direction == "up" and "']+1" or "'[-1")
end

key.set('n', '[<Space>', function() blank_line("up") end)
key.set('n', ']<Space>', function() blank_line("down") end)

-- Relative Number Toggle
local num_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
    group = num_group,
    callback = function() vim.opt.relativenumber = true end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
    group = num_group,
    callback = function() vim.opt.relativenumber = false end,
})

-- Terminal Auto-Insert
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "term://*",
    command = "startinsert",
})

-- Make Telescope borders match your theme's primary color
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#7aa2f7" }) -- Example blue
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#7aa2f7" })
