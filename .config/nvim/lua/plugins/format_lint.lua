return {
	{
		"stevearc/conform.nvim",
		event = "InsertEnter",
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
			},
			-- Set default options
			default_format_opts = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
				lsp_format = "fallback", -- not recommended to change
			},
			-- Set up format-on-save
			-- format_on_save = {
			-- 	lsp_format = "fallback",
			-- 	timeout_ms = 500,
			-- },
			-- Customize formatters
			formatters = {},
		},
	},
}
