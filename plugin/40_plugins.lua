local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

-- Standard Plugins ===========================================================

later(function()
	vim.cmd("packadd nvim.undotree")
	vim.cmd("packadd nohlsearch")
end)

-- Tree-sitter ================================================================

now_if_args(function()
	local ts_update = function()
		vim.cmd("TSUpdate")
	end
	Config.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")

	add({
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
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
	Config.new_autocmd("FileType", filetypes, ts_start, "Start tree-sitter")

	add({ "https://github.com/windwp/nvim-ts-autotag" })
	require("nvim-ts-autotag").setup()
end)

-- Language servers ===========================================================

now_if_args(function()
	add({ "https://github.com/neovim/nvim-lspconfig" })
	add({ "https://github.com/mason-org/mason.nvim" })
	add({ "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" })
	add({ "https://github.com/mason-org/mason-lspconfig.nvim" })
	add({ "https://github.com/j-hui/fidget.nvim" })
	-- add({ "folke/lazydev.nvim" })

	-- require({ "fidget" }).setup({})
	require("mason").setup()

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
	add({ "https://github.com/stevearc/conform.nvim" })

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
	add({ "https://github.com/rafamadriz/friendly-snippets" })
end)

-- Colorscheme ================================================================

Config.now(function()
	add({
		{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
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

	vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = "#191724", bg = "#f6c177", bold = true })
	vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { bg = "#31748f", bold = true })

	Config.new_autocmd("ColorScheme", nil, function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	end)

	vim.cmd("color rose-pine")
end)

-- Thanks =====================================================================

later(function()
	add({ "https://github.com/jsongerber/thanks.nvim" })
	local thanks = require("thanks")
	thanks.setup({
		star_on_install = false,
	})
end)

-- Fun ========================================================================

later(function()
	add({ "https://github.com/eandrju/cellular-automaton.nvim" })
end)

later(function()
	add({ "https://github.com/szymonwilczek/vim-be-better" })
end)

later(function()
	add({ "https://github.com/tamton-aquib/duck.nvim" })
end)

-- Git ========================================================================

later(function()
	add({ "https://github.com/nvim-lua/plenary.nvim" })
	add({ "https://github.com/kdheepak/lazygit.nvim" })
end)

-- Views ======================================================================

later(function()
	-- add({ "https://github.com/OXY2DEV/markview.nvim" })
	-- add({ "https://github.com/OXY2DEV/helpview.nvim" })
end)

-- Typst ======================================================================

later(function()
	add({
		{
			src = "https://github.com/chomosuke/typst-preview.nvim",
			version = vim.version.range("1"),
		},
	})

	local typstPreview = require("typst-preview")
	typstPreview.setup({
		follow_cursor = false,
		dependencies_bin = { ["tinymist"] = "tinymist" },
	})
end)

-- Linting ====================================================================

now_if_args(function()
	add({ "https://github.com/mfussenegger/nvim-lint" })

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
