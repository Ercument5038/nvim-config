return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		enabled = false,

		priority = 49,

		-- For blink.cmp's completion
		-- source
		dependencies = {
			"saghen/blink.cmp",
		},
	},
	{
		"OXY2DEV/helpview.nvim",
		lazy = false, -- Recommended
		ft = "help",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
