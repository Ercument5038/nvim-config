return {
	{
		"rose-pine/neovim",
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
			-- vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		"diegoulloao/neofusion.nvim",
		priority = 1000,
		config = true,
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
		priority = 1000,
		config = true,
	},
}
