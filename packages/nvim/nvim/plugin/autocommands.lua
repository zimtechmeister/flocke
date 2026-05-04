-- Quality of life autocommands
local qol = vim.api.nvim_create_augroup("QualityOfLife", { clear = true })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = qol,
    callback = function()
        vim.highlight.on_yank()
    end,
})


-- Stop automatic insertion of comments on newline 'fo-table' for reference
-- vim.api.nvim_create_autocmd("FileType", {
--     desc = "Stop automatic insertion of comments on newline",
--     group = qol,
--     pattern = "*",
--     callback = function()
--         vim.opt.formatoptions:remove { "c", "r", "o" }
--     end,
-- })

-- show line numbers and more in terminal buffer
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "show line numbers and more in terminal buffer",
    group = qol,
    callback = function()
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.signcolumn = 'yes'
    end,
})
