require('sidekick').setup()

vim.keymap.set(
    { "n", "x", "i", "t" },
    "<c-.>",
    function() require("sidekick.cli").toggle() end,
    { desc = "Sidekick Toggle", }
)
vim.keymap.set(
    { 'n' },
    '<leader>ag',
    function() require("sidekick.cli").toggle({ name = "gemini", focus = true }) end,
    { desc = "Sidekick Toggle CLI", }
)
vim.keymap.set(
    { 'n' },
    '<leader>ad',
    function() require("sidekick.cli").close() end,
    { desc = "Detach a CLI Session", }
)
vim.keymap.set(
    { 'n' },
    "<leader>as",
    function() require("sidekick.cli").select({ filter = { installed = true } }) end,
    { desc = "Select CLI", }
)
vim.keymap.set(
    { "x", "n" },
    "<leader>at",
    function() require("sidekick.cli").send({ msg = "{this}" }) end,
    { desc = "Send This", }
)
vim.keymap.set(
    { "x", "n" },
    "<leader>af",
    function() require("sidekick.cli").send({ msg = "{file}" }) end,
    { desc = "Send File", }
)
vim.keymap.set(
    { "x" },
    "<leader>av",
    function() require("sidekick.cli").send({ msg = "{selection}" }) end,
    { desc = "Send Visual Selection", }
)
vim.keymap.set(
    { "n", "x" },
    "<leader>ap",
    function() require("sidekick.cli").prompt() end,
    { desc = "Sidekick Select Prompt", }
)

-- Next Edit Suggestions (NES)
-- add keymaps to toggle nes
vim.keymap.set(
    { 'n' },
    '<leader>r',
    function()
        require("sidekick").nes_jump_or_apply()
    end,
    {
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion'
    }
)
vim.keymap.set(
    { "n" },
    "<leader>art",
    function() require("sidekick.nes").toggle() end,
    { desc = "Toggle Next Edit Suggestions", }
)
vim.keymap.set(
    { "n" },
    "<leader>aru",
    function() require("sidekick.nes").update() end,
    { desc = "Update Next Edit Suggestions", }
)
