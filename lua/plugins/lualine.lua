--
-- Set lualine as statusline
-- See `:help lualine.txt`
return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = '|',
            section_separators = '',
        },
    }
}
