local theme = require("theme")

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.device({ name = "synaptics-tm3276-022", accel_profile = "adaptive" })

hl.config({
    general = {
        border_size = 2,
        gaps_in = 5,
        gaps_out = { top = 10, right = 10, bottom = 10, left = 10 },

        col = {
            active_border = theme.colors.base05,
            inactive_border = theme.colors.base11,
        },

        layout = "scrolling",

        no_focus_fallback = true,

        resize_on_border = true,

        snap = {
            enabled = true,
        },

    },

    decoration = {
        shadow = {
            color = theme.colors.base11,
            color_inactive = theme.colors.base11 .. "00",
        },
    },

    input = {
        kb_layout = "eu, de, us",
        accel_profile = "flat",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
        },
    },

    gestures = {
        workspace_swipe_distance = 200,
        workspace_swipe_touch_invert = true,
        workspace_swipe_direction_lock = false,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        font_family = theme.fonts.serif or "serif",
        background_color = theme.colors.base11,
    },

    binds = {
        focus_preferred_method = 1,
        window_direction_monitor_fallback = false,
    },

    cursor = {
        hotspot_padding = 3,
        inactive_timeout = 5,
        no_warps = true,
    },

    scrolling = {
        fullscreen_on_one_column = false,
        column_width = 1.0,
        focus_fit_method = 1,
        follow_focus = false,
        follow_min_visible = 0.3,
        explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
        wrap_focus = false,
        direction = "down"
    },
})
