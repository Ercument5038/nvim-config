return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-ui-select.nvim",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "%.git/", ".stfolder/" },
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					fzf = {},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>fc", builtin.colorscheme, {})
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})

			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = "~/dotfiles/.config/nvim/" })
				-- builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "search in config" })
		end,
	},
}
