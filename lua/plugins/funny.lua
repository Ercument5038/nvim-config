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
			end, { desc = "Spawn a duck" })
			vim.keymap.set("n", "<leader>dk", function()
				require("duck").cook()
			end, { desc = "Cook a duck" })
			vim.keymap.set("n", "<leader>da", function()
				require("duck").cook_all()
			end, { desc = "Cook all ducks" })
		end,
	},
	{
		"szymonwilczek/vim-be-better",
		cmd = "VimBeBetter",
	},
}
