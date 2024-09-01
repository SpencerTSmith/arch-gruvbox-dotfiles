return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			keys = {
				{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
				{ "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
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
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},

	keys = {
		{ "<leader>d",  "",                                                                                   desc = "Debug",                         mode = { "n", "v" } },
		{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Debug: Breakpoint Condition" },
		{ "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Debug: Toggle Breakpoint" },
		{ "<leader>dc", function() require("dap").continue() end,                                             desc = "Debug: Continue" },
		{ "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Debug: Run with Args" },
		{ "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Debug: Run to Cursor" },
		{ "<leader>dg", function() require("dap").goto_() end,                                                desc = "Debug: Go to Line (No Execute)" },
		{ "<leader>dI", function() require("dap").step_into() end,                                            desc = "Debug: Step Into" },
		{ "<leader>dj", function() require("dap").down() end,                                                 desc = "Debug: Down" },
		{ "<leader>dk", function() require("dap").up() end,                                                   desc = "Debug: Up" },
		{ "<leader>dl", function() require("dap").run_last() end,                                             desc = "Debug: Run Last" },
		{ "<leader>do", function() require("dap").step_out() end,                                             desc = "Debug: Step Out" },
		{ "<leader>dn", function() require("dap").step_over() end,                                            desc = "Debug: Step Over" },
		{ "<leader>dp", function() require("dap").pause() end,                                                desc = "Debug: Pause" },
		{ "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Debug: Toggle REPL" },
		{ "<leader>ds", function() require("dap").session() end,                                              desc = "Debug: Session" },
		{ "<leader>dt", function() require("dap").terminate() end,                                            desc = "Debug: Terminate" },
		{ "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Debug: Widgets" },
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
					config.configurations = {
						{
							name = "Launch file",
							type = "cppdbg",
							request = "launch",
							-- args = function()
							-- 	local args_string = vim.fn.input("Input arguments: ")
							-- 	return vim.split(args_string, " ")
							-- end,
							program = function()
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
							end,
							cwd = "${workspaceFolder}",
							stopAtEntry = false,
						},
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})
	end,
}
