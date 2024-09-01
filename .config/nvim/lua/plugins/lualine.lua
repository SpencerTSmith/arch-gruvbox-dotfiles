return {
	'nvim-lualine/lualine.nvim',
	opts = {
		options = {
			theme = 'gruvbox',
			disabled_filetypes = {
				'dashboard',
			}
		},
		extensions = { "oil", "nvim-dap-ui", "fugitive", "mason", "neo-tree", "lazy" }
	}
}
