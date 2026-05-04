vim.g.undotree_WindowLayout = 4
vim.g.undotree_ShortIndicators = 1
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = '[U]ndotreeToggle' })
