if not vim.g.vscode then
	return {
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")
			-- local ui = require("dapui")

			require("nvim-dap-virtual-text").setup({})
			require("dapui").setup()

			dap.adapters.lldb = {
				type = "executable",
				command = "/home/poutima/bin/lldb-dap",
				name = "lldb",
			}
			dap.adapters.gdb = {
				type = "executable",
				command = "/usr/bin/gdb",
				args = { "-i", "dap", "--eval-command", "set pretty print on" },
			}
			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = true,
					args = {},
				},
			}
		end,
	}
end
