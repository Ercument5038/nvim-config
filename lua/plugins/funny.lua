return {
	{
		"efueyo/td.nvim",
	},
	{
		"alec-gibson/nvim-tetris",
	},
	{
		"eandrju/cellular-automaton.nvim",
		-- config = function()
		--     vim.keymap.set("n", "<leader>cmr", "<cmd>CellularAutomaton make_it_rain<CR>")
		--     vim.keymap.set("n", "<leader>cgl", "<cmd>CellularAutomaton game_of_life<CR>")
		--     vim.keymap.set("n", "<leader>csm", "<cmd>CellularAutomaton scramble<CR>")
		-- end,
	},
	{
		"ThePrimeagen/vim-be-good",
	},
	{
		"jim-fx/sudoku.nvim",
		config = function()
			require("sudoku").setup({})
		end,
	},
}
