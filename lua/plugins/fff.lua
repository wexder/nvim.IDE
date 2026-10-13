return {
	"dmtrKovalenko/fff",
	build = "nix run .#release",
	opts = {
		debug = {
			enabled = false,
			show_scores = true,
		},
	},
	lazy = false, -- the plugin lazy-initialises itself
	keys = {
		{
			"<leader>f",
			function()
				local fff = require("fff")
				local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
				fff.find_files_in_dir(root)
			end,
			desc = "FFFind files",
		},
		{
			"<leader>st",
			function()
				local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
				require("fff").live_grep({ cwd = root, grep = { modes = { "fuzzy", "plain" } } })
			end,
			desc = "Live fffuzy grep",
		},
		{
			"<leader>fp",
			function()
				require("fff").find_files_in_dir(vim.fn.input("Path > "))
			end,
			desc = "FFFind files",
		},
		{
			"<leader>fw",
			function()
				require("fff").live_grep_under_cursor()
			end,
			mode = { "n", "x" },
			desc = "Search current word / selection",
		},
	},
}
