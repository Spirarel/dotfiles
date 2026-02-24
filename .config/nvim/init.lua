-- 1. Bootstrap lazy.nvim (the plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Load modules
require("options")
require("plugins")
require("keymaps")
require("autocmds")
require("lsp")
require("auto_hl").setup()
