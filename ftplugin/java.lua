local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
    return
end

-- Determine OS
local home = os.getenv "HOME"
if vim.fn.has "mac" == 1 then
    WORKSPACE_PATH = home .. "/workspace/"
    CONFIG = "mac"
elseif vim.fn.has "unix" == 1 then
    WORKSPACE_PATH = home .. "/workspace/"
    CONFIG = "linux"
else
    print "Unsupported system"
end

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
    return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local config2 = {
    cmd = {
        'jdt-language-server',
        '-data',
        workspace_dir,
    },
    root_dir = root_dir,
    settings = {},
}

config2['on_attach'] = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>cd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>cD", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
    -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
    -- you make during a debug session immediately.
    -- Remove the option if you do not want that.
    -- You can use the `JdtHotcodeReplace` command to trigger it manually
    local jdtls = require('jdtls')

    jdtls.setup.add_commands()
    jdtls.setup_dap {}
end
require('jdtls').start_or_attach(config2)
