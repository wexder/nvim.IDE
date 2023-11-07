-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            require("rose-pine").setup({
                dark_variant = 'main',
                disable_background = true,
                disable_float_background = true,
            })
        end
    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use 'nvim-lualine/lualine.nvim' -- Fancier statusline


    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            { 'simrat39/rust-tools.nvim' },          -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required

        }
    }

    use({
        "L3MON4D3/LuaSnip",
        run = "make install_jsregexp",
        requires = {
            { "rafamadriz/friendly-snippets" },
        }
    })

    use 'nvim-tree/nvim-web-devicons'
    -- use {
    --     'akinsho/bufferline.nvim',
    --     branch = "main",
    -- }
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup({
            shade_terminals = false,
        })
    end }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end

    }
    use {
        'navarasu/onedark.nvim',
    }
    use {
        'RRethy/vim-illuminate',
        config = function()
            require('illuminate').configure({})
        end
    }
    use {
        "EdenEast/nightfox.nvim",
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly',                   -- optional, updated every week. (see issue #1193)
    }
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                ignore_lsp = { "sumneko_lua", "terraformls" },
                detection_methods = { "pattern", "lsp" },
            }
        end
    }
    use {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    }
    use("eandrju/cellular-automaton.nvim")
    use { "mfussenegger/nvim-jdtls" }
    use { 'mfussenegger/nvim-dap' }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use { "jose-elias-alvarez/null-ls.nvim" }
    use { "jay-babu/mason-null-ls.nvim" }
    use { "folke/neodev.nvim" }
    use({
        "aserowy/tmux.nvim",
        config = function()
            return require("tmux").setup({
                redirect_to_clipboard = true,
            })
        end
    })
    use { 'ray-x/go.nvim' }
    use { 'ray-x/guihua.lua' }
    use { 'robertbasic/vim-hugo-helper' }
    -- Experimental
    -- use { "github/copilot.vim" }
    use {
        "chrsm/impulse.nvim",
        requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    }
    use { 'mbledkowski/neuleetcode.vim' }
    use { 'smithbm2316/centerpad.nvim' }

    use { 'vrischmann/tree-sitter-templ' }
end)
