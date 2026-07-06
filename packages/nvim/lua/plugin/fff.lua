require('fff').setup({
    prompt_vim_mode = true,
    layout = {
        prompt_position = 'top',
    },
})
vim.keymap.set('n', '<leader>ff', function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set('n', '<leader>f/', function() require('fff').live_grep() end, { desc = 'LiFFFe grep' })
