local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = false,
    direction = 'float',
})
function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>og", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

local lazydocker = Terminal:new({
    cmd = "lazydocker",
    hidden = false,
    direction = 'float',
})
function _lazydocker_toggle()
    lazydocker:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>od", "<cmd>lua _lazydocker_toggle()<CR>", { noremap = true, silent = true })

local term1 = Terminal:new({
    cmd = "zsh",
    hidden = false,
    direction = 'horizontal',
})
function _term1_toggle()
    term1:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>oo", "<cmd>lua _term1_toggle()<CR>", { noremap = true, silent = true })

local term2 = Terminal:new({
    cmd = "zsh",
    hidden = false,
    direction = 'horizontal',
})
function _term2_toggle()
    term2:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>ot", "<cmd>lua _term2_toggle()<CR>", { noremap = true, silent = true })
