-- Helper Functions
local nmap = function(suffix, rhs, desc)
	vim.keymap.set("n", suffix, rhs, { desc = desc })
end
local xmap = function(suffix, rhs, desc)
	vim.keymap.set("x", suffix, rhs, { desc = desc })
end

local nmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("x", "<Leader>" .. suffix, rhs, { desc = desc })
end

_G.Config.leader_group_clues = {
	{ mode = "n", keys = "<Leader>b", desc = "+Buffer" },
	{ mode = "n", keys = "<Leader>d", desc = "+Ducks" },
	{ mode = "n", keys = "<Leader>e", desc = "+Explore/Edit" },
	{ mode = "n", keys = "<Leader>f", desc = "+Find" },
	{ mode = "n", keys = "<Leader>g", desc = "+Git" },
	{ mode = "n", keys = "<Leader>l", desc = "+Language" },
	-- { mode = "n", keys = "<Leader>m", desc = "+Map" },
	-- { mode = "n", keys = "<Leader>o", desc = "+Other" },
	-- { mode = "n", keys = "<Leader>s", desc = "+Session" },
	{ mode = "n", keys = "<Leader>t", desc = "+Terminal" },
	-- { mode = "n", keys = "<Leader>v", desc = "+Visits" },

	-- { mode = "x", keys = "<Leader>g", desc = "+Git" },
	{ mode = "x", keys = "<Leader>l", desc = "+Language" },
}

-- Basics
nmap_leader("<leader>", "<CMD>source %<CR>", "Source current file")

nmap("<C-q>", "<C-v>")
nmap("<C-i>", "<C-i>zz")
nmap("<C-o>", "<C-o>zz")
nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("G", "Gzz")
nmap("x", [["_x]])
nmap("vig", "ggVG")
nmap("yig", ":%y<CR>")
nmap("dig", ":%d<CR>")
nmap("E", "$")
nmap("B", "0")

xmap("E", "$")
xmap("B", "0")
xmap("<leader>d", [["_d]])
xmap("<leader>p", [["_dP]]) -- P macht das gleiche

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- b for Buffer
local new_scratch_buffer = function()
	vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

nmap_leader("ba", "<Cmd>b#<CR>", "Alternate")
nmap_leader("bd", "<Cmd>lua MiniBufremove.delete()<CR>", "Delete")
nmap_leader("bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>", "Delete!")
nmap_leader("bs", new_scratch_buffer, "Scratch")
nmap_leader("bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", "Wipeout")
nmap_leader("bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", "Wipeout!")

-- e is for Explore/Edit
local edit_plugin_file = function(filename)
	return string.format("<Cmd>edit %s/plugin/%s<CR>", vim.fn.stdpath("config"), filename)
end
local explore_at_file = "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>"
local explore_at_config = "<Cmd>lua MiniFiles.open('~/.config/nvim', false)<CR>"
local explore_quickfix = function()
	vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and "cclose" or "copen")
end
local explore_locations = function()
	vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and "lclose" or "lopen")
end

nmap_leader("ed", "<Cmd>lua MiniFiles.open()<CR>", "Directory")
nmap_leader("ef", explore_at_file, "File directory")
-- nmap_leader("ec", explore_at_config, "Config directory")
-- nmap_leader('ei', '<Cmd>edit $MYVIMRC<CR>',                 'init.lua')
-- nmap_leader('ek', edit_plugin_file('20_keymaps.lua'),       'Keymaps config')
-- nmap_leader('em', edit_plugin_file('30_mini.lua'),          'MINI config')
nmap_leader("en", "<Cmd>lua MiniNotify.show_history()<CR>", "Notifications")
-- nmap_leader('eo', edit_plugin_file('10_options.lua'),       'Options config')
-- nmap_leader('ep', edit_plugin_file('40_plugins.lua'),       'Plugins config')
nmap_leader("eq", explore_quickfix, "Quickfix list")
nmap_leader("eQ", explore_locations, "Location list")

-- f for Find
local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'

nmap_leader("f/", '<Cmd>Pick history scope="/"<CR>', '"/" history')
nmap_leader("f:", '<Cmd>Pick history scope=":"<CR>', '":" history')
nmap_leader("fa", '<Cmd>Pick git_hunks scope="staged"<CR>', "Added hunks (all)")
nmap_leader("fA", pick_added_hunks_buf, "Added hunks (buf)")
nmap_leader("fb", "<Cmd>Pick buffers<CR>", "Buffers")
nmap_leader("fc", "<Cmd>Pick git_commits<CR>", "Commits (all)")
nmap_leader("fC", '<Cmd>Pick git_commits path="%"<CR>', "Commits (buf)")
nmap_leader("fd", '<Cmd>Pick diagnostic scope="all"<CR>', "Diagnostic workspace")
nmap_leader("fD", '<Cmd>Pick diagnostic scope="current"<CR>', "Diagnostic buffer")
nmap_leader("ff", "<Cmd>Pick files<CR>", "Files")
nmap_leader("fg", "<Cmd>Pick grep_live<CR>", "Grep live")
nmap_leader("fG", '<Cmd>Pick grep pattern="<cword>"<CR>', "Grep current word")
nmap_leader("fh", "<Cmd>Pick help<CR>", "Help tags")
nmap_leader("fH", "<Cmd>Pick hl_groups<CR>", "Highlight groups")
nmap_leader("fl", '<Cmd>Pick buf_lines scope="all"<CR>', "Lines (all)")
nmap_leader("fL", '<Cmd>Pick buf_lines scope="current"<CR>', "Lines (buf)")
nmap_leader("fm", "<Cmd>Pick git_hunks<CR>", "Modified hunks (all)")
nmap_leader("fM", '<Cmd>Pick git_hunks path="%"<CR>', "Modified hunks (buf)")
nmap_leader("fr", "<Cmd>Pick resume<CR>", "Resume")
nmap_leader("fR", '<Cmd>Pick lsp scope="references"<CR>', "References (LSP)")
nmap_leader("fs", pick_workspace_symbols_live, "Symbols workspace (live)")
nmap_leader("fS", '<Cmd>Pick lsp scope="document_symbol"<CR>', "Symbols document")
nmap_leader("fv", '<Cmd>Pick visit_paths cwd=""<CR>', "Visit paths (all)")
nmap_leader("fV", "<Cmd>Pick visit_paths<CR>", "Visit paths (cwd)")

-- g is for Git
nmap_leader("gl", "<Cmd>LazyGit<CR>", "LazyGit")

-- l is for Language
local inlay_hints = function()
	if vim.lsp.inlay_hint then
		local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
		vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = 0 })
		vim.notify("Inlay Hints set to: " .. tostring(not is_enabled))
	else
		print("Inlay hints not supported in this Neovim version")
	end
end

nmap_leader("la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Actions")
nmap_leader("ld", "<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic popup")
nmap_leader("lf", '<Cmd>lua require("conform").format()<CR>', "Format")
nmap_leader("li", "<Cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation")
nmap_leader("lh", "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
nmap_leader("lH", inlay_hints, "Inlay Hints")
nmap_leader("lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
nmap_leader("lR", "<Cmd>lua vim.lsp.buf.references()<CR>", "References")
nmap_leader("ls", "<Cmd>lua vim.lsp.buf.definition()<CR>", "Source definition")
nmap_leader("lt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition")

xmap_leader("lf", '<Cmd>lua require("conform").format()<CR>', "Format selection")

-- t is for Terminal
nmap_leader("tT", "<Cmd>horizontal term<CR>", "Terminal (horizontal)")
nmap_leader("tt", "<Cmd>vertical term<CR>", "Terminal (vertical)")

-- d is for Duck
nmap_leader("dd", function()
	require("duck").hatch("ඞ")
end, "Spawn a duck")
nmap_leader("dk", function()
	require("duck").cook()
end, "Cook a duck")
nmap_leader("da", function()
	require("duck").cook_all()
end, "Cook all ducks")

-- u is for Undotree
nmap_leader("u", vim.cmd.UndotreeToggle, "Toggle UndoTree")

-- v is for Visits
local edit_by_rank = function(rank)
	local visits = require("mini.visits")

	-- local sort = visits.gen_sort.default({ recency_weight = 0 })
	local sort = visits.gen_sort.z()
	local paths = visits.list_paths(nil, { sort = sort })

	if paths[rank] then
		vim.cmd.edit(paths[rank])
	else
		vim.notify("No file at rank " .. rank)
	end
end

nmap_leader("v1", function()
	edit_by_rank(1)
end, "most frequent")
nmap_leader("v2", function()
	edit_by_rank(2)
end, "second most frequent")
nmap_leader("v3", function()
	edit_by_rank(3)
end, "third most frequent")
nmap_leader("v4", function()
	edit_by_rank(4)
end, "fourth most frequent ")
