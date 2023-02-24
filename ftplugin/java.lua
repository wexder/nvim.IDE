local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
    return
end

-- Determine OS
local home = os.getenv "HOME"
local launcher_path = vim.fn.glob(
        home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
    )
if #launcher_path == 0 then
    launcher_path = vim.fn.glob(
            home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
            1,
            1
        )[1]
end
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

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

-- NOTE: for debugging
-- git clone git@github.com:microsoft/java-debug.git ~/.config/lvim/.java-debug
-- cd ~/.config/lvim/.java-debug/
-- ./mvnw clean install
-- local bundles = vim.fn.glob(
--     home .. "/development/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
-- )
local bundles = {
    vim.fn.glob(home ..
    "/development/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
};
-- if #bundles == 0 then
--   bundles = vim.fn.glob(
--     home .. "/development/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
--     1,
--     1
--   )
-- end

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. home .. "/.local/share/nvim/lsp_servers/jdtls/lombok.jar",
        "-Xms4g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        launcher_path,
        "-configuration",
        home .. "/.local/share/nvim/lsp_servers/jdtls/config_" .. CONFIG,
        "-data",
        workspace_dir,
    },
    -- on_attach = function(client, bufnr)
    --     jdtls.setup.add_commands()
    --     jdtls.setup_dap {}
    -- end,
    root_dir = root_dir,
    settings = {
        java = {
            jdt = {
                ls = {
                    vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx4G -Xms200m"
                }
            },
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                comments = {
                    enabled = false,
                },
                settings = {
                    profile = "Steller",
                    url = home .. "/.config/lvim/steller.xml",
                },
            },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
        },
        contentProvider = { preferred = "fernflower" },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },
    flags = {
        allow_incremental_sync = true,
        server_side_fuzzy_completion = true,
    },
    init_options = {
        bundles = bundles,
    },
}

config['on_attach'] = function(client, bufnr)
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
    require('jdtls').setup_dap({})
end

require('jdtls').start_or_attach(config)
