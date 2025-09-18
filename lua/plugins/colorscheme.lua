return {
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				enable = {
					terminal = true,
					legacy_highlights = true,
					migrations = true,
				},
				styles = {
					italic = false,
				},
			})
			vim.cmd.colorscheme("rose-pine")
			vim.api.nvim_set_hl(0, "@markup.bold.markdown", { fg = "#f6c177", bold = true })
			vim.api.nvim_set_hl(0, "@markup.italic.markdown", { fg = "#31748f", bold = true })
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		event = "VeryLazy",
		priority = 1000,
	},
	{
		"dgox16/oldworld.nvim",
		event = "VeryLazy",
		priority = 1000,
	},
}
