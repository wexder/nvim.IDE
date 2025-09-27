return {
    "navarasu/onedark.nvim",
    init = function()
        require('onedark').load()
        vim.cmd("colorscheme onedark")
    end,
    config = function()
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
    end
}
