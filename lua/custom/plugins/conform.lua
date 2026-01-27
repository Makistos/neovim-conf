-- Lightweight yet powerful formatter plugin for Neovim
if not vim.g.vscode then
	return {
		"stevearc/conform.nvim",
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
		},
		config = function()
			require("conform").setup({
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
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					go = { "gofmt" },
				},
			})

			-- Linter commands by filetype (can have multiple per filetype)
			local linters = {
				python = {
					{
						cmd = function()
							local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
							return string.format("ruff check %s", cwd)
						end,
						title = "Ruff",
					},
				},
				cpp = {
					{
						cmd = function()
							local file = vim.fn.expand("%:p")
							local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
							return string.format(
								"clang-tidy %s -p %s --quiet 2>&1 | sed 's/\\x1b\\[[0-9;]*m//g'",
								file,
								cwd
							)
						end,
						title = "Clang-Tidy",
					},
				},
				c = {
					{
						cmd = function()
							local file = vim.fn.expand("%:p")
							local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
							return string.format(
								"clang-tidy %s -p %s --quiet 2>&1 | sed 's/\\x1b\\[[0-9;]*m//g'",
								file,
								cwd
							)
						end,
						title = "Clang-Tidy",
					},
				},
				lua = {
					{
						cmd = function()
							local file = vim.fn.expand("%:p")
							return string.format("luacheck %s", file)
						end,
						title = "Luacheck",
					},
				},
				typescript = {
					{
						cmd = function()
							local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
							return string.format("npx eslint %s --format unix 2>&1", cwd)
						end,
						title = "ESLint",
					},
				},
				typescriptreact = {
					{
						cmd = function()
							local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
							return string.format("npx eslint %s --format unix 2>&1", cwd)
						end,
						title = "ESLint",
					},
				},
				javascript = {
					{
						cmd = function()
							local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
							return string.format("npx eslint %s --format unix 2>&1", cwd)
						end,
						title = "ESLint",
					},
				},
				javascriptreact = {
					{
						cmd = function()
							local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
							return string.format("npx eslint %s --format unix 2>&1", cwd)
						end,
						title = "ESLint",
					},
				},
				go = {
					{
						cmd = function()
							local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
							return string.format("staticcheck %s/... 2>&1", cwd)
						end,
						title = "Staticcheck",
					},
					{
						cmd = function()
							local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
							return string.format("go vet %s/... 2>&1", cwd)
						end,
						title = "Go Vet",
					},
				},
			}

			-- Run all linters for current filetype and populate quickfix
			vim.api.nvim_create_user_command("Lint", function()
				local ft = vim.bo.filetype
				local ft_linters = linters[ft]

				if not ft_linters then
					vim.notify("No linter configured for filetype: " .. ft, vim.log.levels.WARN)
					return
				end

				local all_output = {}
				local titles = {}

				for _, linter in ipairs(ft_linters) do
					table.insert(titles, linter.title)
					local cmd = linter.cmd()
					-- Set errorformat for clang-tidy (file:line:col: severity: message)
					-- vim.opt.errorformat:prepend("%f:%l:%c: %trror: %m")
					-- vim.opt.errorformat:prepend("%f:%l:%c: %tarning: %m")
					-- vim.opt.errorformat:prepend("%f:%l:%c: %tote: %m")
					-- vim.notify("Running: " .. cmd, vim.log.levels.INFO)
					local output = vim.fn.systemlist(cmd)
					for _, line in ipairs(output) do
						if line ~= "" then
							table.insert(all_output, line)
						end
					end
				end

				-- Use a simple errorformat that handles file:line:col: message
				local efm = "%f:%l:%c: %m,%f:%l: %m,%f: %m"
				vim.fn.setqflist({}, " ", {
					title = "Lint [" .. table.concat(titles, ", ") .. "]",
					lines = all_output,
					efm = efm,
				})

				if #all_output > 0 then
					vim.cmd("copen")
				else
					vim.notify("No issues found", vim.log.levels.INFO)
				end
			end, { desc = "Run all linters for current filetype" })

			vim.keymap.set("n", "cc", "<cmd>Lint<cr>", { desc = "Run linters for filetype", silent = true })
		end,
	}
end
