return {
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
	},
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
	},
	{
		"tamton-aquib/duck.nvim",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>dd", function()
				require("duck").hatch("ඞ")
			end, {})
			vim.keymap.set("n", "<leader>dk", function()
				require("duck").cook()
			end, {})
			vim.keymap.set("n", "<leader>da", function()
				require("duck").cook_all()
			end, {})
		end,
	},
	{
		"szymonwilczek/vim-be-better",
		cmd = "VimBeBetter",
	},
}
