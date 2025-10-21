return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup({
				custom_surroundings = {
					["b"] = { output = { left = "**", right = "**" } },
					["i"] = { output = { left = "*", right = "*" } },
				},
				n_lines = 500,
			})

			require("mini.statusline").setup({})
			---@diagnostic disable-next-line: duplicate-set-field
			MiniStatusline.section_location = function()
				return "%2l│%-2v"
			end

			require("mini.pairs").setup({})

			require("mini.icons").setup({})
			MiniIcons.mock_nvim_web_devicons()

			require("mini.jump").setup({
				silent = true,
			})

			-- If you need indentation highlighting
			-- require("mini.indentscope").setup({
			-- 	draw = {
			-- 		animation = require("mini.indentscope").gen_animation.none(),
			-- 	},
			-- })
		end,
	},
}
