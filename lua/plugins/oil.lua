return {
	{
		"stevearc/oil.nvim",
		keys = {
			{
				"<leader>e",
				":Oil<cr>",
				desc = "Toggle Oil",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {

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
					-- return name == ".." or name == ".git"
					return name == ".."
				end,
			},
		},
	},
}
