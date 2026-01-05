vim.loader.enable()

-- General
vim.opt.undofile       = true  -- Enable persistent undo (see also `:h undodir`)

vim.opt.backup         = false -- Don't store backup while overwriting the file
vim.opt.writebackup    = false -- Don't store backup while overwriting the file

vim.opt.updatetime     = 250   -- Decrease time before swap file is written and CursorHold event is triggered

vim.opt.mouse          = 'a'   -- Enable mouse for all available modes

-- Appearance
vim.g.have_nerd_font   = true    -- Set to true if you have a Nerd Font installed and selected in the terminal

vim.opt.breakindent    = true    -- Indent wrapped lines to match line start
vim.opt.cursorline     = true    -- Highlight current line
vim.opt.linebreak      = true    -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.opt.number         = true    -- Show line numbers
vim.opt.relativenumber = true    -- Show relative line numbers
vim.opt.splitbelow     = true    -- Horizontal splits will be below
vim.opt.splitright     = true    -- Vertical splits will be to the right

vim.opt.wrap           = false   -- Display long lines as just one line

vim.opt.colorcolumn    = "80"    -- Highlight column at 80 characters

vim.opt.signcolumn     = 'yes'   -- Always show sign column (otherwise it will shift text)
vim.opt.fillchars      = 'eob: ' -- Don't show `~` outside of buffer

-- extra UI options
vim.opt.showmode       = false -- Don't show the mode, since it's already in the status line

vim.opt.pumheight      = 15 -- Limit max height of the popup menu

vim.opt.list           = true -- show some helper symbols
vim.opt.listchars      = { tab = '→ ', trail = '·', nbsp = '␣', extends = '»', precedes = '«' } -- define the symbols

-- Editing
vim.opt.clipboard      = 'unnamedplus' -- Use system clipboard for all operations

vim.opt.scrolloff      = 8             -- Keep 8 lines above/below the cursor when scrolling

vim.opt.ignorecase     = true          -- Ignore case when searching (use `\C` to force not doing that)
vim.opt.hlsearch       = true          -- Highlight all search results
vim.opt.incsearch      = true          -- Show search results while typing
vim.opt.infercase      = true          -- Infer letter cases for a richer built-in keyword completion
vim.opt.smartcase      = true          -- Don't ignore case when searching if pattern has upper case
vim.opt.smartindent    = true          -- Make indenting smart

vim.opt.inccommand     = 'split'       -- Preview substitutions live, as you type

vim.opt.expandtab      = true          -- Use spaces instead of tabs
vim.opt.tabstop        = 4             -- Number of spaces that a <Tab> counts for
vim.opt.softtabstop    = 4             -- Number of spaces that a <Tab> counts for while editing
vim.opt.shiftwidth     = 4             -- Number of spaces to use for each step of (auto)indent

vim.opt.virtualedit    = 'block'       -- Allow going past the end of line in visual block mode
vim.opt.formatoptions  = 'qjl1'        -- Don't autoformat comments

vim.opt.completeopt    = {             -- Customize completions
    'fuzzy',
    'menuone',
    'noinsert',
    'popup',
    'preview'
}

-- Command line completion options
vim.opt.wildmode       = "noselect:lastused,full"
vim.opt.wildoptions    = "pum"

-- Neovide
-- NOTE: some settings are configured in a neovide/config.toml file
if vim.g.neovide then
    vim.g.neovide_confirm_quit = true

    -- zoom in/out
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.25)
    end)
    vim.keymap.set("n", "<C-0>", function()
        vim.g.neovide_scale_factor = 1.0
    end)
end
