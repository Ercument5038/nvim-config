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

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.txt", "*.typ" },
	desc = "Wrapping text over the lines instead of straigh",
	group = vim.api.nvim_create_augroup("ercu-spezial", { clear = true }),
	callback = function()
		vim.cmd("normal! ggVGgw")
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.css", "*.html" },
	desc = "Reloading Colorizer because it sometimes doenst want to work",
	group = vim.api.nvim_create_augroup("ercu-spezial", { clear = true }),
	callback = function()
		vim.cmd("ColorizerReloadAllBuffers")
	end,
})

vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.css", "*.html" },
	desc = "Attaching Colorizer because it sucks and doesnt do it autmatically",
	group = vim.api.nvim_create_augroup("ercu-spezial", { clear = true }),
	callback = function()
		vim.cmd("ColorizerAttachToBuffer")
	end,
})
