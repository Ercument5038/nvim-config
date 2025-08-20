-- Define a custom highlight group for yank feedback
vim.api.nvim_command("hi YankHighlight guifg=#e0def4 guibg=#eb6f82")

-- Create an autocmd for TextYankPost event to apply the highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight" })
	end,
})

-- disable minipairs when inside obsidian vault

local obsidian_vault = "/home/erc/vault/"

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		if string.find(file, obsidian_vault, 1, true) then
			vim.b[args.buf].minipairs_disable = true
		else
			vim.b[args.buf].minipairs_disable = false
		end
	end,
})
