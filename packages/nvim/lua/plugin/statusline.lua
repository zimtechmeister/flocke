local hl = function(group)
    return vim.api.nvim_get_hl(0, {
        name = group,
        link = false,
        create = false,
    })
end

local set_hl_groups = function()
    local st = hl("StatusLine")
    local cur = hl("CursorLine")

    local groups = {
        Default     = { fg = st.fg, bg = st.bg },
        ModeNormal  = { fg = st.bg, bg = st.fg, bold = true },
        ModePending = { fg = st.bg, bg = "#cc241d", bold = true },
        ModeVisual  = { fg = st.bg, bg = "#458588", bold = true },
        ModeInsert  = { fg = st.bg, bg = "#98971a", bold = true },
        ModeCommand = { fg = st.bg, bg = "#d79921", bold = true },
        ModeReplace = { fg = st.bg, bg = "#b16286", bold = true },
        DiagError   = { fg = hl("DiagnosticError").fg or "#cc241d", bg = st.bg },
        DiagWarn    = { fg = hl("DiagnosticWarn").fg or "#d79921", bg = st.bg },
        DiagInfo    = { fg = hl("DiagnosticInfo").fg or "#458588", bg = st.bg },
        DiagHint    = { fg = hl("DiagnosticHint").fg or "#98971a", bg = st.bg },
    }

    for name, opts in pairs(groups) do
        local base = "StatusLine" .. name

        vim.api.nvim_set_hl(0, base, opts)

        vim.api.nvim_set_hl(0, base .. "Inverted", { fg = opts.bg, bg = opts.fg })
        vim.api.nvim_set_hl(0, base .. "Dimbg", { fg = opts.fg, bg = cur.bg })
        vim.api.nvim_set_hl(0, base .. "Dimfg", { fg = cur.bg, bg = opts.bg })
        vim.api.nvim_set_hl(0, base .. "InvertedDimbg", { fg = opts.bg, bg = cur.bg })
        vim.api.nvim_set_hl(0, base .. "InvertedDimfg", { fg = cur.bg, bg = opts.fg })
    end
end

-- Compile and apply our custom highlights
set_hl_groups()

-- Re-compile statusline colours when the colorscheme changes
local statusline_group = vim.api.nvim_create_augroup("my_statusline", {})
vim.api.nvim_create_autocmd("ColorScheme", {
    group = statusline_group,
    desc = "Re-apply statusline highlights on colorscheme change",
    callback = set_hl_groups,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    group = statusline_group,
    desc = "Redraw statusline when changing mode",
    callback = function()
        vim.cmd("redrawstatus")
    end,
})


local mode_component = function()
    -- Note: termcodes \19 and \22 are ^S and ^V
    ---- stylua: ignore
    local mode_settings = {
        ["n"] = { name = "NORMAL", hl = "Normal" },
        ["no"] = { name = "OP-PENDING", hl = "Pending" },
        ["nov"] = { name = "OP-PENDING", hl = "Pending" },
        ["noV"] = { name = "OP-PENDING", hl = "Pending" },
        ["no\22"] = { name = "OP-PENDING", hl = "Pending" },
        ["niI"] = { name = "NORMAL", hl = "Normal" },
        ["niR"] = { name = "NORMAL", hl = "Normal" },
        ["niV"] = { name = "NORMAL", hl = "Normal" },
        ["nt"] = { name = "NORMAL", hl = "Normal" },
        ["ntT"] = { name = "NORMAL", hl = "Normal" },
        ["v"] = { name = "VISUAL", hl = "Visual" },
        ["vs"] = { name = "VISUAL", hl = "Visual" },
        ["V"] = { name = "V-LINE", hl = "Visual" },
        ["Vs"] = { name = "V-LINE", hl = "Visual" },
        ["\22"] = { name = "V-BLOCK", hl = "Visual" },
        ["\22s"] = { name = "V-BLOCK", hl = "Visual" },
        ["s"] = { name = "SELECT", hl = "Insert" },
        ["S"] = { name = "S-LINE", hl = "Normal" },
        ["\19"] = { name = "S-BLOCK", hl = "Normal" },
        ["i"] = { name = "INSERT", hl = "Insert" },
        ["ic"] = { name = "INSERT", hl = "Insert" },
        ["ix"] = { name = "INSERT", hl = "Insert" },
        ["R"] = { name = "REPLACE", hl = "Replace" },
        ["Rc"] = { name = "REPLACE", hl = "Replace" },
        ["Rx"] = { name = "REPLACE", hl = "Replace" },
        ["Rv"] = { name = "V-REPLACE", hl = "Replace" },
        ["Rvc"] = { name = "V-REPLACE", hl = "Replace" },
        ["Rvx"] = { name = "V-REPLACE", hl = "Replace" },
        ["c"] = { name = "COMMAND", hl = "Command" },
        ["cv"] = { name = "EX", hl = "Command" },
        ["ce"] = { name = "EX", hl = "Command" },
        ["r"] = { name = "REPLACE", hl = "Normal" },
        ["rm"] = { name = "MORE", hl = "Normal" },
        ["r?"] = { name = "CONFIRM", hl = "Normal" },
        ["!"] = { name = "SHELL", hl = "Normal" },
        ["t"] = { name = "TERMINAL", hl = "Command" },
    }

    local mode = mode_settings[vim.fn.mode(1)] or {}

    return table.concat({
        "%#StatusLineMode" .. mode.hl .. "Inverted" .. "#",
        "%#StatusLineMode" .. mode.hl .. "#" .. mode.name,
        "%#StatusLineMode" .. mode.hl .. "InvertedDimbg" .. "#",
    })
end


-- show macro recording in statusline
function _G.get_macro_recording()
    local reg = vim.fn.reg_recording()
    if reg == "" then return "" end
    return "REC @" .. reg .. " "
end

-- show search count information in statusline
function _G.get_search_count()
    if vim.v.hlsearch == 0 then return "" end

    local last_search = vim.fn.getreg('/')
    if last_search == '' then return "" end

    -- Safe search count limits to prevent lockups on huge files
    local search = vim.fn.searchcount({ maxcount = 9999, timeout = 500 })
    if search.total == 0 then return "" end

    -- Styled to use your existing ModeCommand highlight group (Yellow)
    return string.format("%%#StatusLineModeCommandDimbg# [%d/%d] ", search.current, search.total)
end

-- show diagnostics in statusline
function _G.get_diagnostics()
    if vim.diagnostic.count == nil then
        return ""
    end

    local counts = vim.diagnostic.count(0)
    local parts = {}
    local signs = {
        [vim.diagnostic.severity.ERROR] = { sign = " ", hl = "DiagError" },
        [vim.diagnostic.severity.WARN]  = { sign = " ", hl = "DiagWarn" },
        [vim.diagnostic.severity.INFO]  = { sign = " ", hl = "DiagInfo" },
        [vim.diagnostic.severity.HINT]  = { sign = " ", hl = "DiagHint" },
    }

    -- Sort severity to keep order consistent
    local severities = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
        vim.diagnostic.severity.INFO,
        vim.diagnostic.severity.HINT,
    }

    for _, severity in ipairs(severities) do
        local n = counts[severity] or 0
        if n > 0 then
            local data = signs[severity]
            table.insert(parts,
                string.format("%%#StatusLine%sDimbg#%s%%#StatusLineDefaultDimbg#%d", data.hl, data.sign, n))
        end
    end

    if #parts == 0 then
        return ""
    end
    return " " .. table.concat(parts, " ") .. " "
end

-- Refresh statusline when macro recording starts/stops NOTE: seems like its not needed updates fast automatically
-- vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
--     callback = function()
--         vim.cmd("redrawstatus")
--     end,
-- })

-- Refresh statusline when diagnostics change
vim.api.nvim_create_autocmd("DiagnosticChanged", {
    group = statusline_group,
    callback = function()
        vim.cmd("redrawstatus")
    end,
})

function _G.render_statusline()
    local active_win = vim.fn.win_getid()
    local status_win = tonumber(vim.g.actual_curwin)

    if status_win and status_win ~= active_win then
        return table.concat({
            "%=",
            "%#StatusLineDefaultDimfg#",
            "%#StatusLineDefaultDimbg# %f %m ",
            "%#StatusLineDefaultDimfg#",
            "%="
        })
    end

    local macro = _G.get_macro_recording()
    local search_count = _G.get_search_count()
    local diagnostics = _G.get_diagnostics()

    return table.concat({
        mode_component(),

        "%#StatusLineDefaultDimbg# %f %m ",
        "%#StatusLineDefaultDimfg#",

        -- Spacer
        "%=",

        (function()
            if macro ~= "" or search_count ~= "" or diagnostics ~= "" then
                return table.concat({
                    "%#StatusLineDefaultDimfg#",
                    "%#StatusLineDefaultDimbg#",
                    "%#StatusLineDiagErrorDimbg#" .. macro,
                    search_count,
                    diagnostics,
                    "%#StatusLineDefaultDimbg#"
                })
            end
            return "%#StatusLineDefault#"
        end)(),

        "%#StatusLineDefaultInverted# %l:%c ",
        "%#StatusLineDefault#"
    })
end

vim.opt.statusline = "%{%v:lua.render_statusline()%}"
