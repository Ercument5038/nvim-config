vim.api.nvim_create_autocmd("filetype", {
	pattern = "netrw",
	desc = "Better mappings for netrw",
	callback = function()
		local bind = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
		end

		-- edit new file
		bind("n", "%")

		-- rename file
		bind("r", "R")

		-- open file
		bind("l", "<CR>")

		-- open file
		bind(".", "gh")

		-- open file
		bind("h", "-^")

		-- open file
		bind("H", "u")
	end,
})
