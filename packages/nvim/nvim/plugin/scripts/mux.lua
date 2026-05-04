local Multiplex = function()
    local nvim_socket = os.getenv("NVIM")
    if nvim_socket then
        -- Try to connect to the parent nvim instance
        local ok, parent_chan = pcall(vim.fn.sockconnect, "pipe", nvim_socket, { rpc = true })

        -- pcall returns status and result. sockconnect returns a channel id > 0 on success.
        if ok and parent_chan and parent_chan ~= 0 then
            -- If connection is successful, we are in a nested nvim.
            -- Send command to parent via RPC and wait for it to be processed.
            -- Using rpcrequest with nvim_exec is a reliable, synchronous way to run a command.
            pcall(vim.fn.rpcrequest, parent_chan, "nvim_exec", "terminal", false)
            vim.fn.chanclose(parent_chan)
            vim.cmd("q")
            return
        end
    end
    -- If not a nested nvim, or if connection failed, open terminal in current instance.
    vim.cmd("terminal")
end

vim.api.nvim_create_user_command("Multiplex", Multiplex, {})

local Cvd = function()
    if vim.bo.buftype == "terminal" then
        local pid = vim.fn.jobpid(vim.b.terminal_job_id)
        if pid and pid > 0 then
            local cwd = vim.fn.system("readlink -f /proc/" .. pid .. "/cwd"):gsub("%s*$", "")
            if cwd and cwd ~= "" then
                vim.cmd("cd " .. cwd)
                vim.notify("Changed cwd to " .. cwd)
            end
        end
    end
end

vim.api.nvim_create_user_command("Cvd", Cvd, {})
