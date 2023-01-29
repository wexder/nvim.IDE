local function telescope_find_files(_)
    require("lvim.core.nvimtree").start_telescope "find_files"
end

local function telescope_live_grep(_)
    require("lvim.core.nvimtree").start_telescope "live_grep"
end

require("nvim-tree").setup({
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true
    },
    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = false,
            }
        }
    },
    view = {
        mappings = {
            list = {
                { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
                { key = "h", action = "close_node" },
                { key = "v", action = "vsplit" },
                { key = "C", action = "cd" },
                { key = "gtf", action = "telescope_find_files", action_cb = telescope_find_files },
                { key = "gtg", action = "telescope_live_grep", action_cb = telescope_live_grep },
            }
        }
    }
})

vim.keymap.set('n', '<leader>e', "<CMD>NvimTreeToggle<CR>")
