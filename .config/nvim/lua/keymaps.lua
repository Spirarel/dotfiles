local key = vim.keymap

-- Normal mode escapes
key.set({ 'i', 'v', 't' }, 'fd', '<Esc>')

-- Display line navigation
key.set('n', 'j', 'gj')
key.set('n', 'gj', 'j')
key.set('n', 'k', 'gk')
key.set('n', 'gk', 'k')

-- Utilities
key.set('n', '<leader>fed', ':e $MYVIMRC<cr>', { desc = 'Open Config' })
key.set('n', 'Y', 'y$', { desc = 'Yank to EOL' })
key.set('n', 'cc', 'ciw', { desc = 'Change Inner Word' })
key.set('n', '<leader>s', ':set spell!<CR>', { silent = true })

-- Tabularize
key.set('v', 'a=', ':Tabularize /=<CR>')
key.set('v', 'a;', ':Tabularize /::<CR>')
key.set('v', 'a-', ':Tabularize /-><CR>')
key.set('v', '<CR>', ':Tabularize /', { remap = true })

-- Buffer/Window Nav
key.set('n', '[b', ':bp<CR>')
key.set('n', ']b', ':bn<CR>')
key.set('n', '<C-h>', '<C-W>h')
key.set('n', '<C-j>', '<C-W>j')
key.set('n', '<C-k>', '<C-W>k')
key.set('n', '<C-l>', '<C-W>l')
key.set('n', '<C-x>', ':wincmd q<CR>')

-- Splits
key.set('n', '<leader>wh', ':vert sbn<CR>')
key.set('n', '<leader>wj', ':below sbn<CR>:wincmd j<CR>')

-- Terminal Escape
key.set('t', 'fd', [[<C-\><C-n>]])

vim.keymap.set("n", "<leader>h", "<cmd>Dashboard<cr>", { desc = "Go to Dashboard" })

-- Remove search highlights with ESC
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
