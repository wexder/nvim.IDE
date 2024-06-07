local lsp = require("lsp-zero")

-- require'lspconfig'.java_language_server.setup{
--     cmd= {'java-language-server'},
-- }
require'lspconfig'.nil_ls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.golangci_lint_ls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.clangd.setup{}

require'lspconfig'.intelephense.setup{
    cmd= {'intelephense', '--stdio'},
}

-- require'lspconfig'.gopls.setup{}
require'lspconfig'.zls.setup{}

require'lspconfig'.clojure_lsp.setup{}

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>cd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>cD", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
end)


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    enabled = function ()
        buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if buftype == "prompt" then return false end
        return true
    end,
    mapping = cmp.mapping.preset.insert({
        -- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        -- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        -- scroll up and down the documentation window
        -- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-d>'] = cmp.mapping.scroll_docs(4),
        -- confirm completion item
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- toggle completion menu
        ['<C-e>'] = cmp_action.toggle_completion(),

        -- tab complete
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,

        -- navigate between snippet placeholder
        ['<C-d>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
})


local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 40

lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
})


vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    signs = true,
    underline = true,
    float = {
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})


-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require('mason-null-ls').setup({
    ensure_installed = { "jq" },
    automatic_installation = false, -- You can still set this to `true`
    handlers = {},
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp.default_setup,
    }
})

local rust_tools = require('rust-tools')
rust_tools.setup({
    server = {
        on_attach = function(client, bufnr)
            vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, { buffer = bufnr })
        end,
        settings = {
            ['rust-analyzer'] = {
                cargo = {
                    autoReload = true,
                    features = "all",
                    buildScripts = {
                        enable = true
                    },
                },
                completion = {
                    autoimport = {
                        enable = true,
                    },
                    postfix = {
                        enable = true,
                    },
                },
                check = {
                    features = "all",
                },

            }
        }
    }
})
