-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.pumheight = 20

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.smartcase = true
vim.opt.ignorecase = true
-- vim.opt.colorcolumn = "80"
--
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local markdown_group = vim.api.nvim_create_augroup('MarkdownSpell', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        vim.opt.spell = true
    end,
    group = markdown_group,
    pattern = '*.md',
})
vim.api.nvim_create_autocmd('BufLeave', {
    callback = function()
        vim.opt.spell = false
    end,
    group = markdown_group,
    pattern = '*.md',
})

vim.opt.foldmethod = "expr"
vim.opt.clipboard = "unnamedplus"

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

