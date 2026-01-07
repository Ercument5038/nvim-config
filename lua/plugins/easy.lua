return {
	{
		-- TODO:
		-- TEST:
		-- FIX:
		-- WARN:
		-- NOTE:
		"folke/todo-comments.nvim",
		event = "VimEnter",
		enabled = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
		keys = {
			{
				"<leader>ft",
				":TodoTelescope<cr>",
				desc = "Search Todo Comments",
			},
		},
	},
	{
		"xiyaowong/transparent.nvim",
		opts = {
			vim.keymap.set("n", "<leader>tt", ":TransparentToggle<CR>", { desc = "Toggle Transparent Background" }),
		},
	},
	{
		"tpope/vim-sleuth",
		enabled = true,
	},
	{
		"letieu/btw.nvim",
		opts = {
			text = "",
		},
	},
	{
		"jsongerber/thanks.nvim",
		event = "VeryLazy",
		opts = { unstar_on_uninstall = false },
	},
	{
		"NStefan002/screenkey.nvim",
		version = "*",
		opks = {
			vim.keymap.set("n", "<leader>sk", ":Screenkey<CR>", { desc = "Toggle Screenkey" }),
		},
	},
	{ "cuducos/spellfile.nvim" },
	{
		"nvzone/typr",
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},
	{
		"tpope/vim-repeat",
	},
}
