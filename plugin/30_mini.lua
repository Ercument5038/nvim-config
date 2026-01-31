local now, later = MiniDeps.now, MiniDeps.later
local now_if_args = _G.Config.now_if_args

now(function()
	require("mini.basics").setup({
		options = { basics = false },
		mappings = {
			windows = true,
			move_with_alt = true,
		},
	})
end)

now(function()
	-- Set up to not prefer extension-based icon for some extensions
	local ext3_blocklist = { scm = true, txt = true, yml = true }
	local ext4_blocklist = { json = true, yaml = true }
	require("mini.icons").setup({
		use_file_extension = function(ext, _)
			return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
		end,
	})

	later(MiniIcons.mock_nvim_web_devicons)

	later(MiniIcons.tweak_lsp_kind)
end)

now_if_args(function()
	-- Makes `:h MiniMisc.put()` and `:h MiniMisc.put_text()` public
	require("mini.misc").setup()

	-- Change current working directory based on the current file path
	MiniMisc.setup_auto_root({ ".git", ".stfolder" })

	-- Restore latest cursor position on file open
	MiniMisc.setup_restore_cursor()

	-- Synchronize terminal emulator background with Neovim's background to remove
	-- possibly different color padding around Neovim instance
	MiniMisc.setup_termbg_sync()
end)

now(function()
	local notify = require("mini.notify")
	notify.setup({
		lsp_progress = {
			enable = true,
		},
	})
end)

now(function()
	local statusline = require("mini.statusline")
	statusline.setup({
		-- config for short section-location
		-- content = {
		--  active = function()
		--    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
		--    local git = MiniStatusline.section_git({ trunc_width = 40 })
		--    local diff = MiniStatusline.section_diff({ trunc_width = 75 })
		--    local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
		--    local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
		--    local filename = MiniStatusline.section_filename({ trunc_width = 140 })
		--    local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
		--    local location = MiniStatusline.section_location({ trunc_width = math.huge })
		--    local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
		--
		--    return MiniStatusline.combine_groups({
		--      { hl = mode_hl, strings = { mode } },
		--      { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
		--      "%<", -- Mark general truncate point
		--      { hl = "MiniStatuslineFilename", strings = { filename } },
		--      "%=", -- End left alignment
		--      { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
		--      { hl = mode_hl, strings = { search, location } },
		--    })
		--  end,
		-- },
	})
end)

later(function()
	require("mini.extra").setup()
end)

later(function()
	local ai = require("mini.ai")
	ai.setup({
		n_lines = 500,
		custom_textobjects = {
			B = MiniExtra.gen_ai_spec.buffer(),
			F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
		},
	})
end)

later(function()
	require("mini.bufremove").setup()
end)

later(function()
	local miniclue = require("mini.clue")
	miniclue.setup({
		clues = {
			Config.leader_group_clues,
			-- miniclue.gen_clues.square_brackets(),
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows({ submode_resize = true }),
			miniclue.gen_clues.z(),
		},

		triggers = {
			{ mode = { "n", "x" }, keys = "<Leader>" }, -- Leader triggers
			{ mode = "n", keys = "\\" }, -- mini.basics
			-- { mode = { "n", "x" }, keys = "[" }, -- mini.bracketed
			-- { mode = { "n", "x" }, keys = "]" },
			{ mode = "i", keys = "<C-x>" }, -- Built-in completion
			{ mode = { "n", "x" }, keys = "g" }, -- `g` key
			{ mode = { "n", "x" }, keys = "'" }, -- Marks
			{ mode = { "n", "x" }, keys = "`" },
			{ mode = { "n", "x" }, keys = '"' }, -- Registers
			{ mode = { "i", "c" }, keys = "<C-r>" },
			{ mode = "n", keys = "<C-w>" }, -- Window commands
			{ mode = { "n", "x" }, keys = "s" }, -- `s` key (mini.surround, etc.)
			{ mode = { "n", "x" }, keys = "z" }, -- `z` key
		},
	})
end)

later(function()
	require("mini.cmdline").setup()
end)

later(function()
	require("mini.comment").setup()
end)

later(function()
	require("mini.cursorword").setup({
		delay = 3000,
	})

	vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "LspReferenceText" })
	vim.api.nvim_set_hl(0, "MiniCursorword", { link = "LspReferenceText" })
end)

-- now_if_args(function()
--  -- Customize post-processing of LSP responses for a better user experience.
--  -- Don't show 'Text' suggestions (usually noisy) and show snippets last.
--  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
--  local process_items = function(items, base)
--    return MiniCompletion.default_process_items(items, base, process_items_opts)
--  end
--  require("mini.completion").setup({
--    lsp_completion = {
--      -- Without this config autocompletion is set up through `:h 'completefunc'`.
--      -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
--      -- (sets up only when needed) and makes it possible to use `<C-u>`.
--      source_func = "omnifunc",
--      auto_setup = false,
--      process_items = process_items,
--    },
--  })
--
--  -- Set 'omnifunc' for LSP completion only when needed.
--  local on_attach = function(ev)
--    vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
--  end
--  _G.Config.new_autocmd("LspAttach", nil, on_attach, "Set 'omnifunc'")
--
--  -- Advertise to servers that Neovim now supports certain set of completion and
--  -- signature features through 'mini.completion'.
--  vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
-- end)

later(function()
	require("mini.diff").setup()
end)

now_if_args(function()
	require("mini.files").setup({
		content = {
			filter = function(fs_entry)
				return fs_entry.name ~= ".stfolder"
			end,
		},
		windows = { preview = true },
	})

	local add_marks = function()
		MiniFiles.set_bookmark("c", vim.fn.stdpath("config"), { desc = "Config" })
		local minideps_plugins = vim.fn.stdpath("data") .. "/site/pack/deps/opt"
		MiniFiles.set_bookmark("p", minideps_plugins, { desc = "Plugins" })
		MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
	end
	_G.Config.new_autocmd("User", "MiniFilesExplorerOpen", add_marks, "Add bookmarks")
end)

later(function()
	local hipatterns = require("mini.hipatterns")
	local hi_words = MiniExtra.gen_highlighter.words
	hipatterns.setup({
		highlighters = {
			-- Highlight a fixed set of common words. Will be highlighted in any place,
			-- not like "only in comments".
			fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
			hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
			todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
			note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

			-- Highlight hex color string (#aabbcc) with that color as a background
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end)

later(function()
	local indentscope = require("mini.indentscope")
	indentscope.setup({
		-- draw = {
		--   animation = indentscope.gen_animation.none(),
		-- }
	})
end)

-- set silent to true if annoying
later(function()
	require("mini.jump").setup()
end)

later(function()
	require("mini.keymap").setup()
	-- Navigate 'mini.completion' menu with `<Tab>` /  `<S-Tab>`
	MiniKeymap.map_multistep("i", "<Tab>", { "pmenu_next" })
	MiniKeymap.map_multistep("i", "<S-Tab>", { "pmenu_prev" })
	-- On `<CR>` try to accept current completion item, fall back to accounting
	-- for pairs from 'mini.pairs'
	MiniKeymap.map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
	-- On `<BS>` just try to account for pairs from 'mini.pairs'
	MiniKeymap.map_multistep("i", "<BS>", { "minipairs_bs" })
end)

later(function()
	require("mini.move").setup()
end)

later(function()
	-- Create pairs not only in Insert, but also in Command line mode
	require("mini.pairs").setup({ modes = { command = true } })
end)

later(function()
	require("mini.pick").setup()
end)

later(function()
	-- Define language patterns to work better with 'friendly-snippets'
	local latex_patterns = { "latex/**/*.json", "**/latex.json" }
	local lang_patterns = {
		tex = latex_patterns,
		plaintex = latex_patterns,
		-- Recognize special injected language of markdown tree-sitter parser
		markdown_inline = { "markdown.json" },
	}

	local snippets = require("mini.snippets")
	local config_path = vim.fn.stdpath("config")
	snippets.setup({
		snippets = {
			-- Always load 'snippets/global.json' from config directory
			snippets.gen_loader.from_file(config_path .. "/snippets/global.json"),
			-- Load from 'snippets/' directory of plugins, like 'friendly-snippets'
			snippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
		},
	})

	-- By default snippets available at cursor are not shown as candidates in
	-- 'mini.completion' menu. This requires a dedicated in-process LSP server
	-- that will provide them. To have that, uncomment next line (use `gcc`).
	-- MiniSnippets.start_lsp_server()
end)

later(function()
	local surround = require("mini.surround")
	surround.setup({
		custom_surroundings = {
			["b"] = { output = { left = "**", right = "**" } },
			["i"] = { output = { left = "*", right = "*" } },
		},
		n_lines = 500,
	})
end)

later(function()
	require("mini.visits").setup()
end)
