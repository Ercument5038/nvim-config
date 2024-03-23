-- Define a custom highlight group for yank feedback
vim.api.nvim_command("hi YankHighlight guifg=#000000 guibg=#ff9999")

-- Create an autocmd for TextYankPost event to apply the highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight" })
	end,
})
