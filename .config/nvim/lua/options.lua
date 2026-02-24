local opt = vim.opt

opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.undofile = true
opt.tabstop = 2
opt.expandtab = true
opt.shiftwidth = 4
opt.autoindent = true
opt.modeline = false
opt.number = true
opt.relativenumber = true
opt.confirm = true
opt.cmdheight = 2
opt.mouse = "a"
opt.wrap = true
opt.linebreak = true -- 'lbr' in your config
opt.clipboard:append("unnamedplus")
-- 1. Reduce the command-line height to zero (Neovim 0.8+)
-- This hides the empty row below your statusline
vim.opt.cmdheight = 0

-- 2. Ensure global statusline is active
-- This merges all window statuslines into one single bar at the bottom
vim.opt.laststatus = 3

vim.g.is_posix = 1
vim.g.mapleader = " "

-- Always show the signcolumn, otherwise it shifts the text when errors appear
vim.opt.signcolumn = "yes"

-- Decrease update time for snappier diagnostic bubbles
vim.opt.updatetime = 250

vim.opt.conceallevel = 2     -- Hides the * and _ markers for a cleaner look
vim.opt.concealcursor = "nc" -- Keeps things concealed in Normal and Command mode

-- Set the width of the undotree window
vim.g.undotree_SplitWidth = 40

-- Set the height of the diff panel
vim.g.undotree_DiffpanelHeight = 15

-- Optional: Automatically focus the undotree window when opened
vim.g.undotree_SetFocusWhenToggle = 1
