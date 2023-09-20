local dap = require('dap')
dap.configurations.java = {
    {
        type = 'java',
        request = 'attach',
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
    },
}

dap.adapters.delve = {
    type = 'server',
    port = 9004,
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
        type = 'delve',
        request = 'attach',
        name = "Debug (Attach) - Remote",
        mode = "remote",
    },
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}"
    }
}

local dapui = require("dapui")
dapui.setup({
    layouts = {
        {
            elements = { {
                id = "scopes",
                size = 0.25
            }, {
                id = "breakpoints",
                size = 0.25
            }, {
                id = "stacks",
                size = 0.25
            }, {
                id = "watches",
                size = 0.25
            } },
            position = "right",
            size = 40
        },
        -- {
        --     elements = { {
        --         id = "repl",
        --         size = 0.5
        --     }, {
        --         id = "console",
        --         size = 0.5
        --     } },
        --     position = "bottom",
        --     size = 10
        -- }
    }
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set("n", "<leader>dc", function() dap.continue() end)
vim.keymap.set("n", "<leader>dbb", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end)
vim.keymap.set("n", "<leader>dT", function() dapui.toggle() end)
vim.keymap.set("n", "<Leader>dbc", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
