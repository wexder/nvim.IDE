return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ":TSUpdate",
        branch = 'main',
        config = function()
            vim.api.nvim_create_autocmd('FileType', { 
                callback = function() 
                    -- Enable treesitter highlighting and disable regex syntax
                    pcall(vim.treesitter.start) 
                    -- Enable treesitter-based indentation
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" 
                end, 
            });
            -- require('nvim-treesitter.configs').setup {
            --     ensure_installed = {
            --         "bash",
            --         "c",
            --         "cpp",
            --         "css",
            --         "dockerfile",
            --         "go",
            --         "html",
            --         "java",
            --         "javascript",
            --         "json",
            --         "lua",
            --         "markdown",
            --         "nix",
            --         "python",
            --         "rust",
            --         "scss",
            --         "toml",
            --         "typescript",
            --         "yaml",
            --         "zig",
            --     },
            --     highlight = {
            --         enable = true,
            --         additional_vim_regex_highlighting = false,
            --     },
            --     indent = {
            --         enable = true,
            --     },
            --     incremental_selection = {
            --         enable = true,
            --         keymaps = {
            --             init_selection = "<A-o>",
            --             node_incremental = "<A-o>",
            --             scope_incremental = "<A-O>",
            --             node_decremental = "<A-i>",
            --         },
            --     },
            -- }
        end,
    },
    -- {
    --     'MeanderingProgrammer/treesitter-modules.nvim',
    --     dependencies = { 'nvim-treesitter/nvim-treesitter' },
    --     ---@module 'treesitter-modules'
    --     ---@type ts.mod.UserConfig
    --     opts = {
    --         -- ensure_installed = { "javascript", "typescript", "c", "lua", "rust", "go", "make", "zig", "dart", "nix", "yaml", "json", "proto"},
    --         -- A list of parser names, or "all"
    --
    --         -- Install parsers synchronously (only applied to `ensure_installed`)
    --         -- sync_install = true,
    --
    --         -- Automatically install missing parsers when entering buffer
    --         -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    --         -- auto_install = true,
    --
    --         highlight = {
    --             -- `false` will disable the whole extension
    --             enable = true,
    --             -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    --             -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    --             -- Using this option may slow down your editor, and you may see some duplicate highlights.
    --             -- Instead of true it can also be a list of languages
    --             additional_vim_regex_highlighting = false,
    --         },
    --         fold = { enable = false },
    --         highlight = { enable = true },
    --         indent = { enable = true },
    --         incremental_selection = {
    --             enable = true,
    --             keymaps = {
    --                 init_selection = "<A-o>",
    --                 node_incremental = "<A-o>",
    --                 scope_incremental = "<A-O>",
    --                 node_decremental = "<A-i>",
    --             },
    --         },
    --     },
    -- },
}
