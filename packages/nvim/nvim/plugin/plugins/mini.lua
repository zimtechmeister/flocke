require('mini.ai').setup()
require('mini.comment').setup()
require('mini.pairs').setup()
require('mini.surround').setup({
    mappings = {
        add = '<leader>sa',        -- Add surrounding in Normal and Visual modes
        delete = '<leader>sd',     -- Delete surrounding
        find = '<leader>sf',       -- Find surrounding (to the right)
        find_left = '<leader>sF',  -- Find surrounding (to the left)
        highlight = '<leader>sh',  -- Highlight surrounding
        replace = '<leader>sr',    -- Replace surrounding
        update_n_lines = '<leader>sn', -- Update `n_lines`
        suffix_last = 'l',         -- Suffix to search with "prev" method
        suffix_next = 'n',         -- Suffix to search with "next" method
    },
})
require('mini.files').setup()
vim.keymap.set("n", "<leader>e", function()
        MiniFiles.open()
    end,
    { desc = 'Open Mini Files' })
vim.keymap.set("n", "<leader>E", function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
    end,
    { desc = 'Open Mini Files at current buffer' })
require('mini.icons').setup()
require('mini.cursorword').setup()
local hipatterns = require('mini.hipatterns')
require('mini.hipatterns').setup({
    highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),
    }
})
require('mini.cmdline').setup()
