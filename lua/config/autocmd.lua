-- Define a custom highlight group for yank feedback
vim.api.nvim_command("hi YankHighlight guifg=#e0def4 guibg=#eb6f82")

-- Create an autocmd for TextYankPost event to apply the highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		-- custom color for highlighting
		vim.hl.on_yank({ higroup = "YankHighlight" })

		-- default colorscheme highlighting
		-- vim.hl.on_yank()
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

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- auto resize splits when terminal windows is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincim =",
})

-- restore cursor to file position in prvious editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so its applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
