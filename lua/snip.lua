local ls = require("luasnip")

ls.setup({
	update_events = "TextChanged, TextChangedI",
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("after/snippets/*.lua", true)) do
	loadfile(ft_path)()
end

vim.keymap.set({ "i", "s" }, "<C-K>", function()
	ls.jump(1)
end, { silent = true, desc = "Jump forward in snippet" })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
	ls.jump(-1)
end, { silent = true, desc = "Jump backward in snippet" })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })
