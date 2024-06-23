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
		config = function()
			vim.keymap.set("n", "<leader>tt", ":TransparentToggle <CR>")
		end,
	},
	{
		"tpope/vim-sleuth",
	},
	{
		"letieu/btw.nvim",
		-- 	config = function()
		-- 		require("btw").setup()
		-- 	end,
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
}
