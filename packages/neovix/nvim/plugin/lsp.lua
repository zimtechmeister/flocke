-- default config provided by nvim-lspconfig
-- for reference https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('jdtls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('nixd')
vim.lsp.enable('copilot')
vim.lsp.enable('air')
vim.lsp.enable('tinymist')
vim.lsp.enable('texlab')
vim.lsp.enable('eslint') -- can only lint but also works for .vue files
vim.lsp.enable('vtsls') -- like more than ts_ls
vim.lsp.enable('tailwindcss')
-- vim.lsp.enable('ts_ls')
-- vim.lsp.enable('vue_ls') -- erlöse mein leid

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Enable autocompletion
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
            vim.keymap.set('i', '<C-Space>', function()
                vim.lsp.completion.get()
            end)
        end

        -- here i dont check for given capabilities anymore
        vim.keymap.set({ 'n', 'x' }, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
            { desc = 'format buffer', buffer = bufnr })
        vim.keymap.set('n', '<leader>lj', '<cmd>lua vim.diagnostic.open_float()<cr>',
            { desc = 'show diagnostic' })
        vim.keymap.set('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>',
            { desc = 'definition', buffer = bufnr })
        vim.keymap.set('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
            { desc = 'declaration', buffer = bufnr })
        vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
            { desc = 'signature help', buffer = bufnr })

        -- copilot lsp inline completion
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
            vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

            vim.keymap.set(
                'i',
                '<C-F>',
                vim.lsp.inline_completion.get,
                { desc = 'LSP: accept inline completion', buffer = bufnr }
            )
            vim.keymap.set(
                'i',
                '<C-G>',
                vim.lsp.inline_completion.select,
                { desc = 'LSP: switch inline completion', buffer = bufnr }
            )
        end
    end
})

vim.diagnostic.config({
    -- hide anoying underline on warnings or errors
    underline = false,
    -- use nerdfont symbols for diagnostics on left
    float = {
        border = 'rounded',
        source = 'if_many',
        header = '',
        prefix = '',
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
