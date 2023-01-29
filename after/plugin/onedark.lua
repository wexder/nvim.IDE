-- require('nightfox').setup({
--     options = {
--         transparent = true, -- Disable setting background
--         terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
--         dim_inactive = false, -- Non focused panes set to alternative background
--     },
--     groups = {
--         all = {
--             LineNr = { fg = "palette.red" },
--             NormalFloat = { fg = "fg1", bg = "NONE" },
--             ['@type.definition'] = {
--                 fg = "palette.yellow"
--             }
--         },
--     },
-- })
-- require('nightfox').compile()
require('onedark').setup {
    style = 'darker',
    transparent = true, -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    highlights = {
        ["@type.qualifier"] = { fg = '$orange' },
        NormalFloat = { fg = "fg1", bg = "NONE" },
        ['@type.definition'] = {
            fg = "$yellow"
        },
        PMenu = { fg = "fg1", bg = "NONE" },
    }
}
require('onedark').load()
vim.cmd("colorscheme onedark")
