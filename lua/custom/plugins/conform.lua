-- Lightweight yet powerful formatter plugin for Neovim
if not vim.g.vscode then
	return {
		"stevearc/conform.nvim",
		-- Load immediately so RuffProject command exists
		lazy = false,
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "never" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
			{
				"<leader>rp",
				"<cmd>RuffProject<cr>",
				mode = "n",
				desc = "Lint Python project with Ruff",
			},
		},

		config = function()
			-- Register RuffProject command
			vim.api.nvim_create_user_command("RuffProject", function()
				local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
				local cmd = string.format("ruff check %s", cwd)
				local output = vim.fn.systemlist(cmd)
				vim.fn.setqflist({}, " ", {
					title = "Ruff Lint",
					lines = output -- vim.split(vim.fn.system(cmd), "\n"),
				})
				if #output > 0 then
					vim.cmd("copen")
				end
			end, { desc = "Run Ruff linter on the entire project and show results" })
			-- Ruff fix command for current line or selected quickfix entry
		end,

		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local ft = vim.bo[bufnr].filetype
				local lsp_timeout, lsp_format_opt

				if ft == "python" or ft == "lua" then
					lsp_timeout = 1000
					lsp_format_opt = "never"
				else
					lsp_timeout = 500
					lsp_format_opt = "fallback"
				end

				return {
					timeout_ms = lsp_timeout,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				python = { "black" },
				cpp = { "clang-format" },
				c = { "clang-format" },
				lua = { "stylua" },
				-- python = { "isort", "black" }, -- optional sequential formatters
			},
		},
		vim.keymap.set("n", "cc", "<cmd>RuffProject<cr>", { desc = "Run Ruff check on project", silent = true })
	}
end

