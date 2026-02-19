local is_vscode = vim.g.vscode ~= nil

require("lazy").setup({
    -- 1. THE AUTOMATORS (Mason)
    -- Automatically installs Ruff, Stylua, Prettier, etc.
    {
        "williamboman/mason.nvim",
        cond = not is_vscode,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cond = not is_vscode,
        opts = {
            -- Installs the native Ruff server and others
            ensure_installed = { "ruff", "basedpyright", "lua_ls" },
        },
    },
    -- LSP Support
    {
        'neovim/nvim-lspconfig',
        cond = not is_vscode,
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
    },

    -- 2. THE FORMATTER (Conform)
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                -- Ruff is 100x faster than Black and handles imports too
                python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    },

    -- 3. THE FOUNDATION (Treesitter)
    {
        "nvim-treesitter/nvim-treesitter",
        -- branch = "main" (this is the default now)
        build = ":TSUpdate",
        cond = not is_vscode,
        config = function()
            -- In the new version, it's often just 'nvim-treesitter' or 'nvim-treesitter.config'
            require("nvim-treesitter").setup({
                ensure_installed = { "lua", "python", "javascript", "vimdoc" },
                highlight = { enable = true },
            })
        end,
    },

    -- 4. COMPLETION & SNIPPETS (Blink.cmp)
    {
        'saghen/blink.cmp',
        version = '*',
        cond = not is_vscode,
        opts = {
            keymap = { preset = 'default' },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        config = function()
            -- This line is key: it tells LuaSnip where your custom files are
            require("luasnip.loaders.from_lua").lazy_load({
                paths = { "~/.config/nvim/lua/snippets/" }
            })
        end,
    },

    -- 5. EDITING UTILS (Including Tabular)
    { 'mg979/vim-visual-multi', cond = not is_vscode },
    { 'godlygeek/tabular' },
    { 'tpope/vim-repeat' },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function() require("nvim-surround").setup({}) end
    },
    {
        'numToStr/Comment.nvim',
        cond = not is_vscode,
        config = function() require('Comment').setup() end
    },

    -- 6. NAVIGATION & SEARCH
    {
        url = "https://codeberg.org/andyg/leap.nvim",
        keys = {
            { "m", "<Plug>(leap-forward)",  mode = { "n", "x", "o" } },
            { "M", "<Plug>(leap-backward)", mode = { "n", "x", "o" } },
        },
    },
    -- Search lens (Replaces is.vim)
    {
        'kevinhwang91/nvim-hlslens', -- Corrected username
        config = function() require('hlslens').setup() end
    },

    -- 7. UI
    {
        'folke/zen-mode.nvim',
        cond = not is_vscode,
        opts = {},
        config = function(_, opts)
            require("zen-mode").setup(opts)

            -- Add your custom keymap here
            vim.keymap.set("n", "<leader><CR>", "<cmd>ZenMode<cr>", { desc = "Toggle Zen Mode" })
        end,
    },
    { 'mbbill/undotree',      cond = not is_vscode },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            theme = 'hyper',
            config = {
                week_header = { enable = true },
                shortcut = {
                    { desc = '󰊳 Update', action = 'Lazy update', key = 'u' },
                    { desc = ' Files', action = 'Telescope find_files', key = 'f' },
                },
            },
        }
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    globalstatus = true, -- One statusline for all splits (standard in 2026)
                },
                sections = {
                    lualine_b = { 'branch', 'diff', 'diagnostics' }, -- Shows LSP errors here
                    lualine_c = { { 'filename', path = 1 } },
                    lualine_x = { 'encoding', 'filetype' },
                }
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({
                defaults = {
                    -- This creates the "Modal" look
                    layout_strategy = "center",
                    layout_config = {
                        center = {
                            width = 0.6,             -- 60% of screen width
                            height = 0.4,            -- 40% of screen height
                            prompt_position = "top", -- Prompt at the top of the modal
                        },
                    },
                    sorting_strategy = "ascending", -- Results grow downwards from the prompt
                    borderchars = {
                        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
                        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                    },
                },
            })

            -- Keybindings
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
        end
    },
})
