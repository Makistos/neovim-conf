if not vim.g.vscode then
	return {
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = { diagnostics = "nvim_lsp", numbers = "buffer_id" },
				vim.keymap.set("n", "<F2>", ":bp<CR>", { desc = "Previous Buffer" }),
				vim.keymap.set("n", "<F3>", ":bn<CR>", { desc = "Next Buffer" }),
			})
		end,
	}
end
