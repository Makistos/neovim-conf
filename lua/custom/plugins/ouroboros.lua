return {
	"jakemason/ouroboros",
	requires = { { "nvim-lua/plenary.nvim" } },
	config = function()
		vim.keymap.set("n", "<leader>cs", "<Cmd>Ouroboros<CR>", { desc = "Toggle header/code", silent = true })
	end,
}
