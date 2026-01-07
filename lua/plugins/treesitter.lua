---@module "lazy"
---@type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			-- Install core parsers at startup
			ts.install({
				"css",
				"html",
				"javascript",
				"python",
				"cpp",
				"c",
				"markdown",
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"lua",
				"luadoc",
				"typst",
			})

			local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

			local ignore_filetypes = {
				"checkhealth",
				"mason",
				"lazy",
			}

			-- Auto-install parsers and enable highlighting on FileType
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				desc = "Enable treesitter highlighting and indentation",
				callback = function(event)
					if vim.tbl_contains(ignore_filetypes, event.match) then
						return
					end

					local lang = vim.treesitter.language.get_lang(event.match) or event.match
					local buf = event.buf

					-- Start highlighting immediatley (works if parser exists)
					pcall(vim.treesitter.start, buf, lang)

					-- Enable treesitter indentation
					-- vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

					if event.match == "qml" then
						vim.bo[buf].indentexpr = "" -- Turn off the broken treesitter indent
						vim.bo[buf].cindent = true -- Turn on C-style indent (Handles { } correctly)
						vim.bo[buf].autoindent = true
					else
						-- For everything else, use Treesitter
						vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end

					-- Install missing parsers (async, no-op if already installed)
					ts.install({ lang })
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
}
