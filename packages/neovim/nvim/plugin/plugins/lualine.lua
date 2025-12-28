local my_theme = require 'lualine.themes.gruvbox'
my_theme.normal.c.bg = 'NONE'
my_theme.insert.c.bg = 'NONE'
my_theme.visual.c.bg = 'NONE'
my_theme.replace.c.bg = 'NONE'
my_theme.command.c.bg = 'NONE'
-- my_theme.inactive.c.bg = 'NONE'


require('lualine').setup({
    options = {
        theme = my_theme, -- "auto"
        component_separators = '',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            {
                'mode',
                separator = { left = '', right = '' },
                right_padding = 2,
            },
        },
        lualine_b = {
            'branch',
            'diagnostics'
        },
        lualine_c = {
            '%=',
            { 'filename', path = 1, },
        },
        lualine_x = {},
        lualine_y = {
            -- show recording macro https://www.lazyvim.org/plugins/ui#lualinenvim
            {
                function() return require("noice").api.status.mode.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            },
            'lsp_status'
        },
        lualine_z = {
            {
                'location',
                separator = { left = '', right = '' },
                left_padding = 2,
            },
        },
    },
})
