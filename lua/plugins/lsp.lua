return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    init = function()
        vim.lsp.enable('nil_ls')
        vim.lsp.enable('gopls')
        vim.lsp.enable('golangci_lint_ls')
        vim.lsp.enable('ts_ls')
        vim.lsp.enable('regols')
        vim.lsp.enable('hls')
        vim.lsp.enable('zls')
        vim.lsp.enable('clojure_lsp')

        vim.lsp.enable('clangd')
        vim.lsp.config('clangd', {
            cmd= { "clangd", "--background-index", "--query-driver=/home/wexder/.conan/data/**/g++-*" },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
        })

        vim.lsp.enable('phpactor')
        vim.lsp.config('phpactor', {
            root_markers = { ".phpactor.json" },
        })

        vim.lsp.enable('pyright')
        vim.lsp.config('pyright', {
            filetypes = { "python" },
            setting= {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true
                    }
                }
            }
        })
        vim.lsp.enable('rust_analyzer')
        vim.lsp.config('rust_analyzer', {
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
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "<leader>cd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "<leader>cD", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "gD", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "d[", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "d]", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "do", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

                vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
            end,
        })
    end,
    dependencies = {
        { 'williamboman/mason.nvim', opts = {} },           -- Optional
        { 'neovim/nvim-lspconfig', },
        {
            "jay-babu/mason-null-ls.nvim",
            opts = {
                ensure_installed = { "jq" },
                automatic_installation = false, -- You can still set this to `true`
                handlers = {},
            },
        },

        -- Autocompletion
        { 
            'hrsh7th/nvim-cmp',
            config = function()
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
            end,
        },         -- Required
        { 'hrsh7th/cmp-nvim-lsp' },     -- Required
        { 'hrsh7th/cmp-buffer' },       -- Optional
        { 'hrsh7th/cmp-path' },         -- Optional
        { 'saadparwaiz1/cmp_luasnip' }, -- Optional
        { 'hrsh7th/cmp-nvim-lua' },     -- Optional

        -- Snippets
        { 'L3MON4D3/LuaSnip' }, -- Required

    }
}
