local M = {}

local banner = {
    " .      .     T h i s   i s   t h e   g a l a x y   o f   . . .             .",
    "                     .              .       .                    .      .",
    ".        .               .       .     .            .",
    "   .           .        .                     .        .            .",
    "             .               .    .          .              .   .         .",
    "               _________________      ____         __________",
    " .       .    /                 |    /    \\    .  |          \\",
    "     .       /    ______   _____| . /      \\      |    ___    |     .     .",
    "             \\    \\    |   |       /   /\\   \\     |   |___>   |",
    "           .  \\    \\   |   |      /   /__\\   \\  . |         _/               .",
    " .     ________>    |  |   | .   /            \\   |   |\\    \\_______    .",
    "      |            /   |   |    /    ______    \\  |   | \\           |",
    "      |___________/    |___|   /____/      \\____\\ |___|  \\__________|    .",
    "  .     ____    __  . _____   ____      .  __________   .  _________",
    "       \\    \\  /  \\  /    /  /    \\       |          \\    /         |      .",
    "        \\    \\/    \\/    /  /      \\      |    ___    |  /    ______|  .",
    "         \\              /  /   /\\   \\ .   |   |___>   |  \\    \\",
    "   .      \\            /  /   /__\\   \\    |         _/.   \\    \\            +",
    "           \\    /\\    /  /            \\   |   |\\    \\______>    |   .",
    "            \\  /  \\  /  /    ______    \\  |   | \\              /          .",
    " .       .   \\/    \\/  /____/      \\____\\ |___|  \\____________/  LS",
    "                               .                                        .",
    "     .                           .         .               .                 .",
    "                .                                   .            .",
}

local icons = {
    FindFile = "",
    FindText = "",
    NewFile = "",
    Project = "",
    History = "",
    Gear = "",
}


function M.get_sections()
    local header = {
        type = "text",
        val = function()
            return banner
        end,
        opts = {
            position = "center",
            hl = "Type",
        },
    }

    local footer = {
        type = "text",
        val = "Main menu",
        opts = {
            position = "center",
            hl = "Number",
        },
    }

    local buttons = {
        opts = {
            hl_shortcut = "Include",
            spacing = 1,
        },
        entries = {
            { "f", icons.FindFile .. "  Find File", "<CMD>Telescope find_files<CR>" },
            { "n", icons.NewFile .. "  New File", "<CMD>ene!<CR>" },
            { "p", icons.Project .. "  Projects ", "<CMD>Telescope projects<CR>" },
            { "r", icons.History .. "  Recent files", ":Telescope oldfiles <CR>" },
            { "t", icons.FindText .. "  Find Text", "<CMD>Telescope live_grep<CR>" },
            -- {
            --     "c",
            --     lvim.icons.ui.Gear .. "  Configuration",
            --     "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>",
            -- },
        },
    }
    return {
        header = header,
        buttons = buttons,
        footer = footer,
    }
end

local function resolve_buttons(theme_name, button_section)
    if button_section.val and #button_section.val > 0 then
        return button_section.val
    end

    local selected_theme = require("alpha.themes." .. theme_name)
    local val = {}
    for _, entry in pairs(button_section.entries) do
        local on_press = function()
            local sc_ = entry[1]:gsub("%s", ""):gsub("SPC", "<leader>")
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
            vim.api.nvim_feedkeys(key, "normal", false)
        end
        local button_element = selected_theme.button(entry[1], entry[2], entry[3])
        -- this became necessary after recent changes in alpha.nvim (06ade3a20ca9e79a7038b98d05a23d7b6c016174)
        button_element.on_press = on_press

        button_element.opts = vim.tbl_extend("force", button_element.opts, entry[4] or button_section.opts or {})

        table.insert(val, button_element)
    end
    return val
end

local function resolve_config(theme_name)
    local selected_theme = require("alpha.themes." .. theme_name)
    local resolved_section = selected_theme.section
    local section = M.get_sections()

    for name, el in pairs(section) do
        for k, v in pairs(el) do
            if name:match "buttons" and k == "entries" then
                resolved_section[name].val = resolve_buttons(theme_name, el)
            elseif v then
                resolved_section[name][k] = v
            end
        end

        resolved_section[name].opts = el.opts or {}
    end

    local opts = {}
    selected_theme.config.opts = vim.tbl_extend("force", selected_theme.config.opts, opts)

    return selected_theme.config
end

local function configure_additional_autocmds()
    local group = "_dashboard_settings"
    vim.api.nvim_create_augroup(group, {})
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "alpha",
        command = "set showtabline=0 | autocmd BufLeave <buffer> set showtabline=" .. vim.opt.showtabline._value,
    })
    -- https://github.com/goolord/alpha-nvim/issues/42
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "alpha",
        command = "set laststatus=0 | autocmd BufUnload <buffer> set laststatus=" .. vim.opt.laststatus._value,
    })
end

local alpha = require("alpha")
local config = resolve_config("dashboard")
alpha.setup(config)
configure_additional_autocmds()
