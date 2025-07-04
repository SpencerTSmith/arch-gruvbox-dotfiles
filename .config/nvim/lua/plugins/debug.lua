return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			keys = {
				{
					"<leader>du",
					function()
						require("dapui").toggle({})
					end,
					desc = "Dap UI",
				},
				{
					"<leader>de",
					function()
						require("dapui").eval()
					end,
					desc = "Eval",
					mode = { "n", "v" },
				},
			},
			opts = {},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end
			end,
		},
		"nvim-neotest/nvim-nio",
		"mason-org/mason.nvim",
		{ "jay-babu/mason-nvim-dap.nvim", opts = { ensure_installed = { "cpptools" } } },
	},
	keys = {
		{
			"<leader>d",
			"",
			desc = "Debug",
			mode = { "n", "v" },
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debug: Breakpoint Condition",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Continue",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Debug: Run to Cursor",
		},
		{
			"<leader>dg",
			function()
				require("dap").goto_()
			end,
			desc = "Debug: Go to Line (No Execute)",
		},
		{
			"<leader>dI",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "Debug: Down",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "Debug: Up",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Debug: Run Last",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<leader>dn",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: step over",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "Debug: pause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Debug: toggle REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").session()
			end,
			desc = "Debug: session",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Debug: terminate",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Debug: widgets",
		},
	},
	config = function()
		require("mason-nvim-dap").setup({
			automatic_installation = true,
			automatic_setup = true,
			ensure_installed = {
				"cpptools",
			},

			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
				cppdbg = function(config)
					local executable_path
					config.configurations = {
						{
							name = "Launch file",
							type = "cppdbg",
							request = "launch",
							program = function()
								executable_path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
								return executable_path
							end,
							args = function()
								local args_string = vim.fn.input("Input arguments: ")
								return vim.split(args_string, " ")
							end,
							cwd = function()
								return vim.fn.fnamemodify(executable_path, ":h")
							end,
						},
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})
	end,
}
