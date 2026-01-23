-- General ====================================================================
vim.g.mapleader = " " -- Use `<Space>` as <Leader> key

vim.o.mouse = "a" -- Enable mouse
vim.o.mousescroll = "ver:25,hor:6" -- Customize mouse scroll
vim.o.switchbuf = "usetab" -- Use already opened buffers when switching
vim.o.undofile = true -- Enable persistent undo
vim.o.swapfile = false -- Disable swapfiles
vim.o.backup = false -- Disable backup when writing a file

vim.o.guicursor = "a:block" -- In all modes cursor is a block

-- vim.o.timeoutlen = 250   -- 250ms to combo a keymap

vim.o.exrc = true -- Enable .nvim.lua project specific config

vim.opt.clipboard:append("unnamedplus") -- Use systemclipboard

vim.opt.isfname:append("@-@") -- Add @ for Neovim to see as part of filename

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd("filetype plugin indent on")
if vim.fn.exists("syntax_on") ~= 1 then
	vim.cmd("syntax enable")
end

-- UI =========================================================================
vim.o.breakindent = true -- Indent wrapped lines to match line start
vim.o.colorcolumn = "80" -- Draw column at 80
vim.o.cursorline = true -- Enable current line highlighting
vim.o.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.number = true -- Show line numbers
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.relativenumber = true -- Show relative numbers
vim.o.scrolloff = 10 -- Set scrolloff to 10 lines
vim.o.shortmess = "CFOSWacosI" -- Disable some built-in completion messages
vim.o.showmode = false -- Don't show mode in command line
vim.o.signcolumn = "yes" -- Always show signcolumn (less flicker)
vim.o.splitbelow = true -- Horizontal splits will be below
vim.o.splitkeep = "screen" -- Reduce scroll during window split
vim.o.splitright = true -- Vertical splits will be to the right
vim.o.winborder = "single" -- Use border in floating windows
vim.o.wrap = false -- Don't visually wrap lines (toggle with \w)

vim.o.cursorlineopt = "screenline,number" -- Show cursor line per screen line

vim.o.conceallevel = 0 -- How concealed text is shown

-- Special UI symbols. More is set via 'mini.basics' later.
vim.o.fillchars = "eob: ,fold:╌"
vim.o.listchars = "extends:…,nbsp:␣,precedes:…,tab:> "

-- Folds (see `:h fold-commands`, `:h zM`, `:h zR`, `:h zA`, `:h zj`)
vim.o.foldlevel = 10 -- Fold nothing by default; set to 0 or 1 to fold
vim.o.foldmethod = "indent" -- Fold based on indent level
vim.o.foldnestmax = 10 -- Limit number of fold levels
vim.o.foldtext = "" -- Show text under fold with its highlighting

-- Editing ====================================================================
vim.o.autoindent = true -- Use auto indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.formatoptions = "rqnl1j" -- Improve comment editing
vim.o.hlsearch = false -- Disable highlighting when searching
vim.o.ignorecase = true -- Ignore case during search
vim.o.incsearch = true -- Show search matches while typing
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.smartindent = true -- Make indenting smart
vim.o.softtabstop = 2 -- Snap to next Tab column
vim.o.spelloptions = "camel" -- Treat camelCase word parts as separate words
vim.o.tabstop = 2 -- Show tab as this number of spaces
vim.o.virtualedit = "block" -- Allow going past end of line in blockwise mode

vim.o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part

vim.o.inccommand = "split" -- Show preview when substituting

-- Autocommands ===============================================================

-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
local f = function()
	vim.cmd("setlocal formatoptions-=c formatoptions-=o")
end
_G.Config.new_autocmd("FileType", nil, f, "Proper 'formatoptions'")

-- Diagnostics ================================================================

-- Neovim has built-in support for showing diagnostic messages. This configures
-- a more conservative display while still being useful.
-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.

-- == MiniMax Config ==
-- local diagnostic_opts = {
--   -- Show signs on top of any other sign, but only for warnings and errors
--   signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },
--
--   -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
--   underline = { severity = { min = 'HINT', max = 'ERROR' } },
--
--   -- Show more details immediately for errors on the current line
--   virtual_lines = false,
--   virtual_text = {
--     current_line = true,
--     severity = { min = 'ERROR', max = 'ERROR' },
--   },
--
--   -- Don't update diagnostics when typing
--   update_in_insert = false,
-- }

-- == My Config ==
local diagnostic_opts = {
	severity_sort = true,

	float = { border = "rounded", source = "if_many" },

	underline = { severity = vim.diagnostic.severity.ERROR },

	signs = { priority = 9999, severity = { min = "WARN", max = "ERROR" } },

	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},

	update_in_insert = false,
}

-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
MiniDeps.later(function()
	vim.diagnostic.config(diagnostic_opts)
end)
