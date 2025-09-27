return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup {
            ignore_lsp = { "sumneko_lua", "terraformls" },
            detection_methods = { "pattern", "lsp" },
        }
    end
}
