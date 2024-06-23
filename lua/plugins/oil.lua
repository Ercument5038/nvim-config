return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				win_options = {
					wrap = true,
				},
				delete_to_trash = true,
				skip_confirm_for_simple_edits = true,
				columns = {
					"icon",
				},
				keymaps = {
					["h"] = "actions.parent",
					["l"] = "actions.select",
					["<leader>e"] = "actions.close",
				},
				view_options = {
					show_hidden = true,
					natural_order = true,
					is_always_hidden = function(name, _)
						return name == ".." or name == ".git"
					end,
				},
			})
			vim.keymap.set("n", "<leader>e", ":Oil<CR>")
		end,
	},
}
