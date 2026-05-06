require('flash').setup({
    modes = {
        char = {
            enabled = false, --disable not needed ftFT jumps
        },
    },
})
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
