local function venv_bin_detection(tool)
	local cwd = vim.loop.cwd()
	local candidates = {
		cwd .. "/.venv/bin/" .. tool,
		cwd .. "/venv/bin/" .. tool,
		"/usr/bin/" .. tool,
		"/usr/local/bin/" .. tool,
	}

	for _, path in ipairs(candidates) do
		if vim.fn.executable(path) == 1 then
			return path
		end
	end

	return tool -- fallback to whatever is on PATH
	-- if vim.fn.executable(cwd .. "/.venv/bin/" .. tool) == 1 then
	-- 	return cwd .. "/.venv/bin/" .. tool
	-- elseif vim.fn.executable(cwd .. "venv/bin/" .. tool) == 1 then
	-- 	return cwd .. "/venv/bin/" .. tool
	-- elseif vim.fn.executable("/usr/bin/" .. tool) == 1 then
	-- 	return "/usr/bin/" .. tool
	-- end
	-- return tool
end

local function venv_python_path()
	-- local cwd = vim.loop.cwd()
	local where = venv_bin_detection("python3")
	-- if where == "python" then
	-- 	return "/usr/bin/python3"
	-- end
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
		require("dap-python").setup(venv_python_path(venv_python_path))
		-- require("dap-python").resolve_python = function()
		-- 	return venv_python_path()
		-- end
	end,
}
