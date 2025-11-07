return {
	{
		-- Maybe in the future change to mini.hipatterns
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {},
		enabled = true,
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
		ft = "html, css, js",
	},
}
