return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
        -- include a picker of your choice, see picker section for more details
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        lang = "rust",
        injector = {
            ["rust"] = {
                before = { "fn main(){}", "struct Solution;" },
            }, ---@type table<lc.lang, lc.inject>
        },
        hooks = {
            ---@type fun(question: lc.ui.Question)[]
            ["question_enter"] = {
                function(question)
                    local problem_dir = vim.fn.stdpath("data") .. "/leetcode/Cargo.toml"
                    local content = [[
                [package]
                name = "leetcode"
                edition = "2024"

                [lib]
                name = "%s"
                path = "%s"
              ]]

                    local file = io.open(problem_dir, "w")
                    if file then
                        local formatted = (content:gsub(" +", "")):format(question.q.frontend_id, question:path())
                        file:write(formatted)
                        file:close()
                    else
                        print("Failed to open file: " .. problem_dir)
                    end
                end,
            },
        },
    },
}
