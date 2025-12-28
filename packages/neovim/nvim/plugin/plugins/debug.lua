local dap = require('dap')
require('dapui').setup()
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}
for _, lang in ipairs({ "c", "cpp" }) do
    dap.configurations[lang] = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
        },
        {
            name = "Select and attach to process",
            type = "gdb",
            request = "attach",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            pid = function()
                local name = vim.fn.input('Executable name (filter): ')
                return require("dap.utils").pick_process({ filter = name })
            end,
            cwd = '${workspaceFolder}'
        },
        {
            name = 'Attach to gdbserver :1234',
            type = 'gdb',
            request = 'attach',
            target = 'localhost:1234',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}'
        },
    }
end

-- keymaps
vim.keymap.set("n", "<leader>du", function() require('dapui').toggle() end, { desc = "Toggle Dap UI" })
vim.keymap.set("n", "<leader>de", function() require('dapui').eval() end, { desc = "Eval" })
vim.keymap.set("n", "<leader>db", function() require('dap').toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    { desc = "Breakpoint Condition" })
vim.keymap.set("n", "<leader>dc", function() require('dap').continue() end, { desc = "Run/Continue" })
vim.keymap.set("n", "<leader>da", function() require("dap").continue({ before = get_args }) end,
    { desc = "Run with Args" })
vim.keymap.set("n", "<leader>dC", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dg", function() require("dap").goto_() end, { desc = "Go to Line (No Execute)" })
vim.keymap.set("n", "<leader>dj", function() require("dap").down() end, { desc = "Down" })
vim.keymap.set("n", "<leader>dk", function() require("dap").up() end, { desc = "Up" })
vim.keymap.set("n", "<leader>dl", function() require('dap').run_last() end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>dsi", function() require('dap').step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dso", function() require('dap').step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dsO", function() require('dap').step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dP", function() require("dap").pause() end, { desc = "Pause" })
vim.keymap.set("n", "<leader>dr", function() require('dap').repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>ds", function() require("dap").session() end, { desc = "Session" })
vim.keymap.set("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate" })
vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })
