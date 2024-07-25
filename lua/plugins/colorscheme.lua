return {
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				enable = {
					terminal = true,
					legacy_highlights = true,
					migrations = true,
				},
				styles = {
					italic = false,
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		"diegoulloao/neofusion.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
		},
	},
	{
		"scottmckendry/cyberdream.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {},
	},
	{
		"dgox16/oldworld.nvim",
		event = "VeryLazy",
		priority = 1000,
	},
}
