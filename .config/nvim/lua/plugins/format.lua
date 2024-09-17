return {
	"stevearc/conform.nvim",
	event = "InsertEnter",
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
		},
		-- Set default options
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Set up format-on-save
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
		-- Customize formatters
		formatters = {},
	},
}
