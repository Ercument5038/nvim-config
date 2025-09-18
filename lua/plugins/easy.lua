return {
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"xiyaowong/transparent.nvim",
		opts = {
			vim.keymap.set("n", "<leader>tt", ":TransparentToggle<CR>"),
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
			vim.keymap.set("n", "<leader>sk", ":Screenkey<CR>"),
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
		"samiulsami/fFtT-highlights.nvim",
		config = function()
			---@module "fFtT-highlights"
			---@type fFtT_highlights.opts
			require("fFtT-highlights"):setup({
				---See below for default configuration options
			})
		end,
	},
}
