-- This function remains the same: it maps keys when an LSP attaches
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
end

-- In Neovim 0.11+, we use the LspAttach autocmd for a cleaner setup
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        on_attach(client, bufnr)
    end,
})

-- 1. Setup Ruff
vim.lsp.config('ruff', {})
vim.lsp.enable('ruff')

-- 2. Setup BasedPyright
vim.lsp.config('basedpyright', {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
            }
        }
    }
})
vim.lsp.enable('basedpyright')

-- 3. Setup Lua LS
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } }
        }
    }
})
vim.lsp.enable('lua_ls')

-- Configure Diagnostic UI
vim.diagnostic.config({
    virtual_text = false, -- Turn off inline text to reduce clutter
    signs = true,       -- Keep symbols in the gutter
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded", -- This gives you the "bubble" look
        source = "always",
        header = "",
        prefix = "",
    },
})

-- Automatically show diagnostics in a floating window on hover
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})
