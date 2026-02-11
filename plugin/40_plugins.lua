local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = _G.Config.now_if_args

-- Tree-sitter ================================================================

now_if_args(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		-- Update tree-sitter parser after plugin is updated
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})
	add({
		source = "nvim-treesitter/nvim-treesitter-textobjects",
		-- Use `main` branch since `master` branch is frozen, yet still default
		-- It is needed for compatibility with 'nvim-treesitter' `main` branch
		checkout = "main",
	})

	-- Define languages which will have parsers installed and auto enabled
	local languages = {
		-- These are already pre-installed with Neovim. Used as an example.
		"lua",
		"vimdoc",
		"markdown",
		"css",
		"html",
		"javascript",
		"python",
		"cpp",
		"c",
		"vim",
		"bash",
		"luadoc",
		"typst",
		"hyprlang",
		"rasi",
		"typescript",
		-- Add here more languages with which you want to use tree-sitter
		-- To see available languages:
		-- - Execute `:=require('nvim-treesitter').get_available()`
		-- - Visit 'SUPPORTED_LANGUAGES.md' file at
		--   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
	}

	vim.treesitter.language.register("javascript", "javascriptreact")

	local isnt_installed = function(lang)
		return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
	end
	local to_install = vim.tbl_filter(isnt_installed, languages)
	if #to_install > 0 then
		require("nvim-treesitter").install(to_install)
	end

	-- Enable tree-sitter after opening a file for a target language
	local filetypes = {}
	for _, lang in ipairs(languages) do
		for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
			table.insert(filetypes, ft)
		end
	end
	local ts_start = function(ev)
		vim.treesitter.start(ev.buf)
	end
	_G.Config.new_autocmd("FileType", filetypes, ts_start, "Start tree-sitter")

	add("windwp/nvim-ts-autotag")
	require("nvim-ts-autotag").setup()
end)

-- Completion =================================================================

now_if_args(function()
	add({
		source = "saghen/blink.cmp",
		checkout = "v1.8.0",
		depends = { "joelazar/blink-calc" },
	})

	local blink = require("blink.cmp")
	blink.setup({
		keymap = {
			-- 'default' (recommended) for mappings similar to built-in completions
			--   <c-y> to accept ([y]es) the completion.
			--    This will auto-import if your LSP supports it.
			--    This will expand snippets if the LSP sent a snippet.
			-- 'super-tab' for tab to accept
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- For an understanding of why the 'default' preset is recommended,
			-- you will need to read `:help ins-completion`
			--
			-- No, but seriously. Please read `:help ins-completion`, it is really good!
			--
			-- All presets have the following mappings:
			-- <tab>/<s-tab>: move to right/left of your snippet expansion
			-- <c-space>: Open menu or open docs if already open
			-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
			-- <c-e>: Hide menu
			-- <c-k>: Toggle signature help
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			preset = "super-tab",

			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"fallback",
			},

			-- disable ctrl k preset keymap
			["<c-k>"] = false,
			["<c-e>"] = false,
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "normal",
		},

		completion = {
			-- By default, you may press `<c-space>` to show the documentation.
			-- Optionally, set `auto_show = true` to show the documentation after a delay.
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
			-- if you want to change the appeae of the menu
			-- https://cmp.saghen.dev/configuration/completion.html#menu
			menu = {
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind" } },
				},
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "calc" },

			-- per_filetype = {
			-- 	lua = { inherit_defaults = true, "lazydev" },
			-- },

			providers = {
				-- lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				calc = {
					name = "Calc",
					module = "blink-calc",
				},
			},
		},

		snippets = {
			preset = "mini_snippets", -- ensure you have the `snippets` source (enabled by default)
		},

		-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
		-- which automatically downloads a prebuilt binary when enabled.
		--
		-- By default, we use the Lua implementation instead, but you may enable
		-- the rust implementation via `'prefer_rust_with_warning'`
		--
		-- See :h blink-cmp-config-fuzzy for more information
		fuzzy = { implementation = "lua" },

		-- Shows a signature help window while you type arguments for a function
		signature = { enabled = true },
	})
end)

-- Language servers ===========================================================

now_if_args(function()
	add("WhoIsSethDaniel/mason-tool-installer.nvim")
	-- add("folke/lazydev.nvim")
	add("j-hui/fidget.nvim")
	add("mason-org/mason-lspconfig.nvim")
	add("mason-org/mason.nvim")
	add("neovim/nvim-lspconfig")

	require("fidget").setup({})
	require("mason").setup()

	local capabilities = require("blink.cmp").get_lsp_capabilities()
	vim.lsp.config("*", { capabilities = capabilities })

	local ensure_installed = {
		"bashls",
		"stylua",
		"cssls",
		"html",
		"jsonls",
		"lua_ls",
		"prettier",
		"pyright",
		"tinymist",
		"typstyle",
		"tailwindcss",
		"ts_ls",
		"qmlls",
	}

	require("mason-tool-installer").setup({
		ensure_installed = ensure_installed,
	})

	-- automatically enable installed language servers by mason
	require("mason-lspconfig").setup({
		automatic_enable = true,
	})

	-- Similar behaivor can be achieved with mini.cursorword
	local lsp_highlights = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if client and client.server_capabilities.documentHighlightProvider then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = ev.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = ev.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(ev2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = ev2.buf })
				end,
				desc = "Remove lsp highlighting",
			})
		end
	end
	-- _G.Config.new_autocmd("LspAttach", nil, lsp_highlights, "Word under cursor highlighting")

	-- Use `:h vim.lsp.enable()` to automatically enable language server based on
	-- the rules provided by 'nvim-lspconfig'.
	-- Use `:h vim.lsp.config()` or 'after/lsp/' directory to configure servers.
	-- Uncomment and tweak the following `vim.lsp.enable()` call to enable servers.
	-- vim.lsp.enable({
	-- 	-- For example, if `lua-language-server` is installed, use `'lua_ls'` entry
	-- 	"lua_ls",
	-- })
end)

-- Formatting =================================================================

later(function()
	add("stevearc/conform.nvim")

	-- See also:
	-- - `:h Conform`
	-- - `:h conform-options`
	-- - `:h conform-formatters`
	require("conform").setup({
		default_format_opts = {
			-- Allow formatting from LSP server if no dedicated formatter is available
			lsp_format = "fallback",
		},
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end
		end,

		-- Make sure that necessary CLI tool is available
		formatters_by_ft = {
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
			lua = { "stylua" },
			-- python = { "ruff" },
			html = { "prettier" },
			css = { "prettier" },
			javascript = { "prettier" },
			json = { "prettier" },
			bash = { "shfmt" },
			javascriptreact = { "prettier" },
			typst = { "typstyle" },
			astro = { "prettier" },
		},
	})
end)

-- Snippets ===================================================================

-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function()
	add("rafamadriz/friendly-snippets")
end)

-- Mason ======================================================================

now_if_args(function()
	add("mason-org/mason.nvim")

	require("mason").setup()
end)

-- Colorscheme ================================================================

now(function()
	add({
		source = "rose-pine/neovim",
		name = "rose-pine",
	})

	local rosepine = require("rose-pine")
	rosepine.setup({
		enable = {
			terminal = true,
			legacy_highlights = true,
			migrations = true,
		},
		styles = {
			italic = false,
			transparency = true,
		},
	})

	vim.api.nvim_set_hl(0, "@markup.bold.markdown", { fg = "#f6c177", bold = true })
	vim.api.nvim_set_hl(0, "@markup.italic.markdown", { fg = "#31748f", bold = true })

	vim.cmd("color rose-pine")
end)

later(function()
	add("https://github.com/jsongerber/thanks.nvim")
	local thanks = require("thanks")
	thanks.setup({
		star_on_install = false,
	})
end)

-- Fun ========================================================================

later(function()
	add("https://github.com/eandrju/cellular-automaton.nvim")
end)

later(function()
	add("https://github.com/szymonwilczek/vim-be-better")
end)

later(function()
	add("https://github.com/tamton-aquib/duck.nvim")
end)

-- later(function()
-- 	add({
-- 		source = "https://github.com/tamton-aquib/ads.nvim",
-- 		depends = { "3rd/image.nvim" },
-- 	})
-- 	require("image").setup()
-- 	require("ads").setup()
-- end)

-- Git ========================================================================

later(function()
	add({
		source = "https://github.com/kdheepak/lazygit.nvim",
		depends = { "nvim-lua/plenary.nvim" },
	})
end)

-- Views ======================================================================

later(function()
	-- add("https://github.com/OXY2DEV/markview.nvim")
	add("https://github.com/OXY2DEV/helpview.nvim")
end)

-- Typst ======================================================================

later(function()
	add({
		source = "chomosuke/typst-preview.nvim",
		checkout = "v1.4.1",
	})
	local typstPreview = require("typst-preview")
	typstPreview.setup({
		follow_cursor = false,
		dependencies_bin = { ["tinymist"] = "tinymist" },
	})
end)

-- Undotree ===================================================================

later(function()
	add("mbbill/undotree")
end)

-- Startup ====================================================================

later(function()
	add("dstein64/vim-startuptime")
	vim.g.startupttime_tries = 10
end)

-- Linting ====================================================================

now_if_args(function()
	add("mfussenegger/nvim-lint")

	local lint = require("lint")
	lint.linters_by_ft = {
		-- markdown = {"vale"}
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			-- Only run the linter in buffers that you can modify in order to
			-- avoid superfluous noise, notably within the handy LSP pop-ups that
			-- describe the hovered symbol using Markdown.
			if vim.bo.modifiable then
				lint.try_lint()
			end
		end,
	})
end)
