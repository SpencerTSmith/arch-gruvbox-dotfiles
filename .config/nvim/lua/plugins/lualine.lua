return {
	"nvim-lualine/lualine.nvim",
	opts = function()
		local custom_gruvbox = require("lualine.themes.gruvbox")
		custom_gruvbox.normal.a.bg = "#FABD2F"
		local opts = {
			options = {
				theme = custom_gruvbox,
				disabled_filetypes = {
					"dashboard",
				},
				component_separators = "",
				section_separators = "",
			},
			extensions = { "oil", "nvim-dap-ui", "fugitive", "mason", "neo-tree", "lazy" },
		}

		return opts
	end,
}
