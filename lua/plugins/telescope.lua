return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            {'nvim-lua/plenary.nvim'},
            {'mrcjkb/telescope-manix'},
            {
                'princejoogie/dir-telescope.nvim',
                opts = {
                    -- these are the default options set
                    hidden = true,
                    no_ignore = false,
                    show_preview = true,
                    follow_symlinks = false,
                }, 
            },
        },
        config = function()
            local telescope = require("telescope")
            local telescopeConfig = require("telescope.config")

            -- Clone the default Telescope configuration
            local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

            -- I want to search in hidden/dot files.
            table.insert(vimgrep_arguments, "--hidden")
            -- I don't want to search in the `.git` directory.
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")
            telescope.setup({
                defaults = {
                    -- `hidden = true` is not supported in text grep commands.
                    vimgrep_arguments = vimgrep_arguments,
                },
            })
        end,
        init = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<leader>f', builtin.git_files, {})
            vim.keymap.set('n', "<leader>sp", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            vim.keymap.set('n', '<leader>st', builtin.live_grep, {})

            require('telescope').load_extension('projects')
            require('telescope').load_extension('manix')
            require("telescope").load_extension("dir")
        end,
    } 
}

