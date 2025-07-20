return {
	{
		"NMAC427/guess-indent.nvim",
	},
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
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
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
