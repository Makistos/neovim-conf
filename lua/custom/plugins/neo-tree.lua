if not vim.g.vscode then
	return {
		"nvim-neo-tree/neo-tree.nvim",
		version = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.keymap.set(
				"n",
				"<leader>nb",
				"<Cmd>Neotree buffers<CR>",
				{ desc = "Toggle Neotree buffers", silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>nf",
				"<Cmd>Neotree filesystem<CR>",
				{ desc = "Toggle Neotree filesystem", silent = true }
			)
		end,
	}
end
