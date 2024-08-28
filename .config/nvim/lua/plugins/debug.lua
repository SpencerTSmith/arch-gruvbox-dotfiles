return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

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
							args = function()
								local args_string = vim.fn.input("Input arguments: ")
								return vim.split(args_string, " ")
							end,
							program = function()
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
							end,
							cwd = "${workspaceFolder}",
							stopAtEntry = false,
						},
						{
							name = "Attach to gdbserver :1234",
							type = "cppdbg",
							request = "launch",
							MIMode = "gdb",
							miDebuggerServerAddress = "localhost:1234",
							miDebuggerPath = vim.fn.exepath("gdb"),
							cwd = "${workspaceFolder}",
							program = function()
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
							end,
						},
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
