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
			local dapui = require("dapui")
			-- local ui = require("dapui")

			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enable_commands = true,
				all_frames = false,
				commented = false,
				highlight_changed_variables = true,
				highlight_new_as_changed = false,
				show_stop_reason = true,
				only_first_definition = true,
				all_references = false,
				clear_on_continue = false,
				text_prefix = "",
				separator = ",",
				info_prefix = "  ",
				error_prefix = "  ",
				virt_lines = false,
				virt_lines_above = true,
				filter_references_pattern = "<module",
				virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
				display_callback = function(variable, buf, stackframe, node, options)
					-- by default, strip out new line characters
					if options.virt_text_pos == "inline" then
						return " = " .. variable.value:gsub("%s+", " ")
					else
						return variable.name .. " = " .. variable.value:gsub("%s+", " ")
					end
				end,
			})
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
			-- Dap keys
			vim.keymap.set("n", "<F6>", dap.step_over, { desc = "Step over", silent = true })
			vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Step into", silent = true })
			vim.keymap.set("n", "S-<F7>", dap.step_out, { desc = "Step out", silent = true })
			vim.keymap.set("n", "<F8>", dap.continue, { desc = "Continue", silent = true })
			vim.keymap.set("n", "S-<F8>", dap.run_to_cursor, { desc = "Run to Cursor", silent = true })
			vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle breakpoint", silent = true })

			vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "Toggle breakpoint", silent = true })
			vim.keymap.set("n", "<leader>brc", dap.run_to_cursor, { desc = "Run to Cursor", silent = true })
			vim.keymap.set(
				"n",
				"<leader>bhv",
				":lua require('dapui').float_element()<CR>",
				{ desc = "Variables hover", silent = true }
			)
			vim.keymap.set("n", "<leader>bc", dap.continue, { desc = "Continue", silent = true })
			vim.keymap.set("n", "<leader>bso", dap.step_over, { desc = "Step over", silent = true })
			vim.keymap.set("n", "<leader>bsi", dap.step_into, { desc = "Step into", silent = true })
			vim.keymap.set("n", "<leader>bst", dap.step_out, { desc = "Step out", silent = true })
			vim.keymap.set("n", "<leader>bsb", dap.step_back, { desc = "Step back", silent = true })
			vim.keymap.set("n", "<leader>brr", dap.restart, { desc = "Restart", silent = true })
			vim.keymap.set("n", "<leader>brs", dap.close, { desc = "Stop", silent = true })

			-- Dap UI keys
			vim.keymap.set("n", "<leader>bu", dapui.toggle, { desc = "Toggle dap-ui", silent = true })
			vim.keymap.set(
				"n",
				"<leader>be",
				"<Cmd>lua require('dapui').eval()<CR>",
				{ desc = "Evaluate value under cursor", silent = true }
			)
			vim.fn.sign_define("DapBreakpoint", {
				text = "⬤",
				texthl = "ErrorMsg",
				linehl = "",
				numhl = "ErrorMsg",
			})

			vim.fn.sign_define("DapBreakpointCondition", {
				text = "⬤",
				texthl = "ErrorMsg",
				linehl = "",
				numhl = "SpellBad",
			})

			require("nvim-dap-virtual-text").setup({})
		end,
	}
end
