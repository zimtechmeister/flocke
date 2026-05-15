require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 0,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        vim.keymap.set('n', '<leader>gh', gitsigns.preview_hunk_inline, { desc = "Git Signs (Preview Hunk)" })
        vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame,
            { desc = "Git Signs (Toggle Current Line Blame)" })
    end
})
