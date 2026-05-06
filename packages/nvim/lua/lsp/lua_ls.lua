return {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            signatureHelp = { enabled = true },
            diagnostics = {
                globals = { "vim", },
            },
        }
    },
}
