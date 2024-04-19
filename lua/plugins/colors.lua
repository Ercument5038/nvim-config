return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				html = { css = true, mode = "foreground" },
				css = { css = true, mode = "foreground" },
			})
		end,
	},
	{
		"ziontee113/color-picker.nvim",
		config = function()
			require("color-picker").setup({
				["icons"] = { "⣿", "⡇" },
			})
		end,

		vim.keymap.set("n", "<leader>pc", "<cmd>PickColor<cr>", {}),
	},
}
