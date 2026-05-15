local theme = require("theme")

-- NOTE: PROBABLY NOT WORKING
hl.config({
    ["plugin:hyprbars"] = {
        enabled = true,
        bar_color = theme.colors.base05,
        bar_height = 16,

        ["col.text"] = theme.colors.base05,
        bar_title_enabled = true,
        bar_text_size = 12, -- Defaulting as we don't pass font sizes yet
        bar_text_font = theme.fonts.serif or "serif",
        bar_text_align = "center",

        bar_buttons_alignment = "right",

        bar_part_of_window = true,
        bar_precedence_over_border = true,

        bar_padding = 8,
        bar_button_padding = 4,

        ["hyprbars-button"] = {
            theme.colors.base08 .. ", 12, , hyprctl dispatch killactive",
            theme.colors.base0B .. ", 12, , hyprctl dispatch setfloating",
        },
    },
})
