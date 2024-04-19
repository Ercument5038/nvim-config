return {
	{
		"NStefan002/screenkey.nvim",
		version = "*",
		config = function()
			require("screenkey").setup()
			vim.keymap.set("n", "<leader>sk", "<cmd>Screenkey<CR>")
		end,
	},
}
