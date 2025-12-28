require("snacks").setup({
    bigfile = { enabled = true },
    dashboard = {
        preset = {
            keys = {
                { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                { icon = " ", key = "t", desc = "Open Terminal", action = ":Multiplex" },
                { icon = " ", key = "p", desc = "Find Project", action = ":lua Snacks.dashboard.pick('projects')" },
                { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
        },
        sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Sessions", section = "session", indent = 2, padding = 1 },
            {
                pane = 2,
                icon = " ",
                title = "Git Status",
                section = "terminal",
                enabled = function()
                    return Snacks.git.get_root() ~= nil
                end,
                cmd = "git status --short --branch --renames",
                height = 5,
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
            },
            -- { section = "startup" }, -- NOTE: this seems to require lazy.nvim
        },
    },
    image = {
        enabled = true,
        doc = {
            inline = vim.g.neovim_mode == "skitty" and true or false,
        }
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
})
-- }

vim.keymap.set('n', '<Esc', function() Snacks.notifier.hide() end, { desc = "Notification (Hide)" })
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = "Notification History" })
vim.keymap.set('n', '<leader>g', function() Snacks.lazygit.open() end, { desc = "Lazygit" })
vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
-- incorrect syntax
-- dont know what this does
-- { "]]",          function() Snacks.words.jump(vim.v.count1) end,      desc = "Next Reference",               mode = { "n", "t" } },
-- { "[[",          function() Snacks.words.jump(-vim.v.count1) end,     desc = "Prev Reference",               mode = { "n", "t" } },

-- -- picker
vim.keymap.set('n', '<leader>fp', function() Snacks.picker.pickers() end, { desc = "Pickers" })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = "Files" })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = "Recent Files" })
-- vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = "Buffers" })
-- start in normal mode
vim.keymap.set('n', '<leader>fb',
    function()
        Snacks.picker.buffers({
            on_show = function()
                vim.cmd.stopinsert()
            end,
        })
    end,
    { desc = "Buffers" }
)
vim.keymap.set('n', '<leader>f/', function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set('n', '<leader>f?', function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
vim.keymap.set('n', '<leader>f:', function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set('n', '<leader>fn', function() Snacks.picker.notifications() end, { desc = "Notification History" })
vim.keymap.set('n', '<leader>fgb', function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
vim.keymap.set('n', '<leader>fk', function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set('n', '<leader>fh', function() Snacks.picker.help() end, { desc = "Help Pages" })
vim.keymap.set('n', '<leader>fc', function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
vim.keymap.set('n', '<leader>fp', function() Snacks.picker.projects() end, { desc = "Projects" })
vim.keymap.set('n', '<leader>f"', function() Snacks.picker.registers() end, { desc = "Registers" })
vim.keymap.set('n', '<leader>fj', function() Snacks.picker.jumps() end, { desc = "Jumps" })
vim.keymap.set('n', '<leader>fm', function() Snacks.picker.marks() end, { desc = "Marks" })
vim.keymap.set('n', '<leader>fd', function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set('n', '<leader>fq', function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set('n', '<leader>fi', function() Snacks.picker.icons() end, { desc = "Icons" })
-- -- LSP
vim.keymap.set('n', '<leader>lpd', function() Snacks.picker.lsp_definitions() end, { desc = "Picker Goto Definition" })
vim.keymap.set('n', '<leader>lpD', function() Snacks.picker.lsp_declaration() end, { desc = "Picker Goto Declaration" })
vim.keymap.set('n', '<leader>lpi', function() Snacks.picker.lsp_implementations() end,
    { desc = "Picker Goto Implementation" })
vim.keymap.set('n', '<leader>lpo', function() Snacks.picker.lsp_type_definitions() end,
    { desc = "Picker Goto T[y]pe Definition" })
vim.keymap.set('n', '<leader>lpr', function() Snacks.picker.lsp_references() end,
    { nowait = true, desc = "Picker References" })
vim.keymap.set('n', '<leader>lps', function() Snacks.picker.lsp_symbols() end, { desc = "Picker LSP Symbols" })
