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

-- Custom Highligts for SecondBrain
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = "#f6c177", bold = true })
		vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = "#eb6f92", bold = true })
	end,
})
