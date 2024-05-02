return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				keymaps = {
					["h"] = "actions.parent",
					["l"] = "actions.select",
					["<leader>e"] = "actions.close",
				},
			})
			vim.keymap.set("n", "<leader>e", ":Oil<CR>")
		end,
	},
}
