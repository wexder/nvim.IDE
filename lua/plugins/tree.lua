local function telescope_find_files(_)
    require("lvim.core.nvimtree").start_telescope "find_files"
end

local function telescope_live_grep(_)
    require("lvim.core.nvimtree").start_telescope "live_grep"
end

return {
    'nvim-tree/nvim-tree.lua',
    init = function()
        vim.keymap.set('n', '<leader>e', "<CMD>NvimTreeToggle<CR>")
    end,
    opts = {
        -- sync_root_with_cwd = true,
        -- respect_buf_cwd = true,
        -- update_cwd = true,
        update_focused_file = {
            enable = true,
            -- update_root = true
        },
        renderer = {
            highlight_git = true,
            icons = {
                show = {
                    git = false,
                }
            }
        },
        on_attach = function(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end
            api.config.mappings.default_on_attach(bufnr)
            -- copy default mappings here from defaults in next section
            vim.keymap.set("n", "cd", api.tree.change_root_to_node,          opts("CD"))

            -- remove a default
            vim.keymap.del("n", "<C-]>", { buffer = bufnr })
            vim.keymap.del("n", "<C-e>", { buffer = bufnr })

            -- add your mappings
            vim.keymap.set("n", "?",     api.tree.toggle_help,                  opts("Help"))
            ---
        end,
        -- view = {
        --     mappings = {
        --         list = {
        --             { key = { "l", "<CR>", "o" }, action = "edit",                 mode = "n" },
        --             { key = "h",                  action = "close_node" },
        --             { key = "v",                  action = "vsplit" },
        --             { key = "C",                  action = "cd" },
        --             { key = "gtf",                action = "telescope_find_files", action_cb = telescope_find_files },
        --             { key = "gtg",                action = "telescope_live_grep",  action_cb = telescope_live_grep },
        --         }
        --     }
        -- }
    },
}

-- vim.g.netrw_keepdir = 0
-- vim.g.netrw_winsize = 10
-- vim.g.netrw_banner = 0
-- vim.g.netrw_localcopydircmd = 'cp -r'
-- vim.keymap.set('n', '<leader>e', "<CMD>Explore %:p:h<CR>")
