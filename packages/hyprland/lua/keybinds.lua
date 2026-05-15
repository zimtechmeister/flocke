hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia-shell")
end)

local focus_left = function()
    local old_window = hl.get_active_window()
    hl.dispatch(hl.dsp.layout("focus left"))
    local new_window = hl.get_active_window()
    if old_window == new_window then
        hl.dispatch(hl.dsp.focus({ workspace = "-1", on_current_monitor = true }))
    end
end
local focus_down = function()
    local old_window = hl.get_active_window()
    hl.dispatch(hl.dsp.layout("focus down"))
    local new_window = hl.get_active_window()
    if old_window == new_window then
        hl.dispatch(hl.dsp.focus({ workspace = "+1", on_current_monitor = true }))
    end
end
local focus_up = function()
    local old_window = hl.get_active_window()
    hl.dispatch(hl.dsp.layout("focus up"))
    local new_window = hl.get_active_window()
    if old_window == new_window then
        hl.dispatch(hl.dsp.focus({ workspace = "-1", on_current_monitor = true }))
    end
end
local focus_right = function()
    local old_window = hl.get_active_window()
    hl.dispatch(hl.dsp.layout("focus right"))
    local new_window = hl.get_active_window()
    if old_window == new_window then
        hl.dispatch(hl.dsp.focus({ workspace = "+1", on_current_monitor = true }))
    end
end

hl.bind("SUPER + Return", hl.dsp.exec_cmd("ghostty"))

hl.bind("SUPER + S", hl.dsp.exec_cmd("screenshot"))

hl.bind("SUPER + Space", hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("noctalia-shell ipc call launcher clipboard"))
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("noctalia-shell ipc call bar toggle"))
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("noctalia-shell ipc call volume muteInput"))
hl.bind("switch:[Lid Switch]", hl.dsp.exec_cmd("noctalia-shell ipc call sessionMenu lockAndSuspend"), { locked = true })


hl.bind("SUPER + M", hl.dsp.exit())
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill())
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = -1, client = 2, action = "toggle" }))
hl.bind("SUPER + D", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + D", hl.dsp.window.pin())

for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind("SUPER + H", focus_left)
hl.bind("SUPER + J", hl.dsp.layout("focus d"))
hl.bind("SUPER + K", hl.dsp.layout("focus u"))
hl.bind("SUPER + L", focus_right)

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

hl.bind("SUPER + CTRL + H", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + K", hl.dsp.layout("colresize -conf"), { repeating = true })
hl.bind("SUPER + CTRL + J", hl.dsp.layout("colresize +conf"), { repeating = true })
hl.bind("SUPER + CTRL + L", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })

hl.bind("SUPER + left", hl.dsp.focus({ monitor = "l" }))
hl.bind("SUPER + down", hl.dsp.focus({ monitor = "d" }))
hl.bind("SUPER + up", hl.dsp.focus({ monitor = "u" }))
hl.bind("SUPER + right", hl.dsp.focus({ monitor = "r" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + SHIFT", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + CTRL", hl.dsp.window.resize(), { mouse = true })


hl.gesture({ fingers = 3, direction = "vertical", scale = 4.0, action = "scroll_move" })
hl.gesture({ fingers = 3, direction = "horizontal", scale = 1.0, action = "workspace" })
-- hl.gesture({ fingers = 3, direction = "down", action = focus_down })
-- hl.gesture({ fingers = 3, direction = "up", action = focus_up })
