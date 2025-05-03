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
	},
	{
		"letieu/btw.nvim",
		opts = {
			text = "",
		},
	},
	{
		"ngtuonghy/live-server-nvim",
		event = "VeryLazy",
		build = ":LiveServerInstall",
		config = function()
			require("live-server-nvim").setup({})
			vim.keymap.set("n", "<leader>lt", function()
				require("live-server-nvim").toggle()
			end)
		end,
	},
	{
		"jsongerber/thanks.nvim",
		event = "VeryLazy",
		opts = { unstar_on_uninstall = true },
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
		"jinh0/eyeliner.nvim",
		opts = {
			highlight_on_key = true,
			dim = true,
			vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#9ccfd8", bold = true, underline = true }),
			vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#31748f", underline = true }),
		},
	},
	{
	    "nvzone/typr",
	    dependencies = "nvzone/volt",
	    opts = {},
	    cmd = { "Typr", "TyprStats" },
	}
}
