return {
	"navarasu/onedark.nvim",
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("onedark").setup({
			style = "darker",
			transparent = true, -- Show/hide background
			term_colors = true, -- Change terminal color as per the selected theme style
			highlights = {
				["@type.qualifier"] = { fg = "$orange" },
				NormalFloat = { fg = "fg1", bg = "NONE" },
				["@type.definition"] = {
					fg = "$yellow",
				},
				PMenu = { fg = "fg1", bg = "NONE" },
			},
		})
		require("onedark").load()
	end,
}
