return {
	{
		"norcalli/nvim-colorizer.lua",
		opts = {},
	},
	{
		"ziontee113/color-picker.nvim",
		opts = {
			["icons"] = { "⣿", "⡇" },
		},
		keys = {
			{
				"<leader>pc",
				":PickColor<cr>",
				desc = "Open colorpicker",
			},
		},
	},
	{
		"mattn/emmet-vim", -- ctrl y + ,
		ft = "html, css",
	},
}
