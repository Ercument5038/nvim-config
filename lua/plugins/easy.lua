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
		keys = { {
			"<leader>tt",
			":TransparentToggle<cr>",
			desc = "Toggle Transparent Background",
		} },
	},
	{
		"tpope/vim-sleuth",
	},
	{
		"letieu/btw.nvim",
		opts = {
			text = "I am Ercüment",
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
	"NStefan002/screenkey.nvim",
	version = "*",
	keys = {
		{ "<leader>sk", "<cmd>Screenkey<cr>", desc = "Start Screen Key" },
	},
}
