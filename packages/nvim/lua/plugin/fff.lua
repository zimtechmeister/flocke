require('fff').setup({
    prompt_vim_mode = true,
    layout = {
        prompt_position = 'top',
    },
})
vim.keymap.set('n', '<leader>ff', function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set('n', '<leader>f/', function() require('fff').live_grep() end, { desc = 'LiFFFe grep' })
-- vim.keymap.set('n', '<leader>fb', function() require('fff').buffers() end, { desc = "BuFFFers" })

-- NOTE: AI slop: buffer picker
local fff = require('fff')
local picker_ui = require('fff.picker_ui')
local file_picker = require('fff.file_picker')

-- Store originals to preserve default file/grep functionality
local original_search = file_picker.search_files_paginated
local original_select = picker_ui.select
local original_metadata = file_picker.get_search_metadata

local buffers = {}
local last_filtered = {}

-- 1. Hook into search
file_picker.search_files_paginated = function(query, ...)
    if picker_ui.state.mode == 'buffers' then
        query = query:lower()
        last_filtered = {}
        for _, b in ipairs(buffers) do
            if b.name:lower():find(query, 1, true) or b.relative_path:lower():find(query, 1, true) then
                table.insert(last_filtered, b)
            end
        end
        return last_filtered
    end
    return original_search(query, ...)
end

-- 2. Hook into metadata
file_picker.get_search_metadata = function()
    if picker_ui.state.mode == 'buffers' then
        return { total_matched = #last_filtered, total_files = #buffers }
    end
    return original_metadata()
end

-- 3. Hook into selection
picker_ui.select = function(action)
    if picker_ui.state.mode == 'buffers' then
        local items = picker_ui.state.filtered_items
        local item = items[picker_ui.state.cursor]
        if item then
            picker_ui.close()
            vim.api.nvim_set_current_buf(item.bufnr)
        end
        return
    end
    return original_select(action)
end

-- 4. Attach the function to the fff module
fff.buffers = function()
    buffers = {}
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_get_option_value('buflisted', { buf = bufnr }) then
            local path = vim.api.nvim_buf_get_name(bufnr)
            local name = vim.fn.fnamemodify(path, ':t')
            table.insert(buffers, {
                name = name == "" and "[No Name]" or name,
                relative_path = path,
                bufnr = bufnr,
                extension = vim.fn.fnamemodify(path, ':e')
            })
        end
    end

    picker_ui.open({ mode = 'buffers', title = 'Buffers' })
end
