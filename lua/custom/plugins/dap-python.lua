local function venv_bin_detection(tool)
	local cwd = vim.loop.cwd()
	if vim.fn.executable(cwd .. "/.venv/bin/" .. tool) == 1 then
		return cwd .. "/.venv/bin/" .. tool
	end
	return tool
end

local function venv_python_path()
	-- local cwd = vim.loop.cwd()
	local where = venv_bin_detection("python")
	if where == "python" then
		return "/usr/bin/python"
	end
	return where
end

return {
	-- {
	"mfussenegger/nvim-dap-python",
	-- 	require("nvim-dap-python").setup("python3"),
	-- 	config = function()
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<leader>pd",
	-- 			":lua require('dap-python').debug_selection()<CR>",
	-- 			{ desc = "Debug selection" }
	-- 		)
	-- 	end,
	-- },
	config = function()
		require("dap-python").setup(venv_python_path())
		require("dap-python").resolve_python = function()
			return venv_python_path()
		end
	end,
}
