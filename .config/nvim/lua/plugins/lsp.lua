return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {},
			},
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					auto_install = true,
					ensure_installed = {
						"lua_ls",
						"clangd",
						"glsl_analyzer",
						"hyprls",
						"pyright",
					},
				},
			},
			"echasnovski/mini.extra",
		},
		config = function()
			local lspconfig = require("lspconfig")

			lspconfig.jsonls.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.texlab.setup({})
			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--fallback-style=llvm",
				},
			})
			lspconfig.glsl_analyzer.setup({})
			lspconfig.pyright.setup({})

			lspconfig.hyprls.setup({})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", function()
						require("mini.extra").pickers.lsp({ scope = "definition" })
					end, "Goto definition")

					map("gr", function()
						require("mini.extra").pickers.lsp({ scope = "references" })
					end, "Goto references")

					map("gI", function()
						require("mini.extra").pickers.lsp({ scope = "implementation" })
					end, "Goto implementation")

					map("<leader>fs", function()
						require("mini.extra").pickers.lsp({ scope = "document_symbol" })
					end, "Document symbols")

					map("<leader>ws", function()
						require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
					end, "Workspace symbols")

					map("<leader>rn", vim.lsp.buf.rename, "Rename")

					map("<leader>ca", vim.lsp.buf.code_action, "Code action")

					map("K", vim.lsp.buf.hover, "Hover documentation")

					map("gD", vim.lsp.buf.declaration, "Goto declaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({
									group = "kickstart-lsp-highlight",
									buffer = event2.buf,
								})
							end,
						})
					end

					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "Toggle Inlay Hints")
					end
				end,
			})
		end,
	},
}
