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
					},
				},
			},
			"echasnovski/mini.extra",
			"folke/snacks.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")

			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--fallback-style=llvm",
					"--background-index",
					"--compile-commands-dir=build",
					"--pch-storage=memory",
					"-j=4",
				},
			})
			lspconfig.jsonls.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.texlab.setup({})
			lspconfig.glsl_analyzer.setup({})
			lspconfig.pyright.setup({})
			lspconfig.hyprls.setup({})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map(
						"gd",
						"<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>",
						"Goto definition"
					)

					map(
						"gr",
						"<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>",
						"Goto references"
					)

					map(
						"gI",
						"<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",
						"Goto implementation"
					)

					map("<leader>lr", vim.lsp.buf.rename, "Rename symbol")

					map("<leader>lc", vim.lsp.buf.code_action, "Code action")

					map("K", vim.lsp.buf.hover, "Hover documentation")

					map(
						"gD",
						"<cmd>FzfLua lsp_declaration jump_to_single_result=true ignore_current_line=true<cr>",
						"Goto declaration"
					)

					map(
						"gT",
						"<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>",
						"Goto type definition"
					)

					map("gh", "<cmd>ClangdSwitchSourceHeader<cr>", "Goto .c/.h")
					map("gH", function()
						vim.cmd("vsplit")
						vim.cmd("ClangdSwitchSourceHeader")
					end, "Open .c/.h in vertical split")

					map("<leader>lf", function()
						vim.cmd("lua Snacks.rename.rename_file()")
					end, "Rename current file")

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
						map("<leader>lt", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "Toggle Inlay Hints")
					end
				end,
			})
		end,
	},
}
