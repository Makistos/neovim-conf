-- lua/custom/plugins/avante.lua
-- Only load if ANTHROPIC_API_KEY is set (home computer)
if not vim.g.vscode and vim.env.ANTHROPIC_API_KEY then
	return {
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			provider = "claude",
			claude = {
				api_key_name = "ANTHROPIC_API_KEY",
				model = "claude-sonnet-4-20250514",
			},
		},
	}
end

-- Return empty table if conditions not met
return {}
