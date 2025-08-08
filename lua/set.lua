vim.opt.guicursor = "a:block"
vim.opt.cursorline = true

vim.g.have_nerd_font = true

vim.opt.mouse = "a"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 150

vim.opt.colorcolumn = "80"

vim.opt.cmdheight = 2

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.showmode = false
vim.opt.pumheight = 10

vim.opt.timeoutlen = 250

vim.o.inccommand = "split"

vim.o.confirm = true

vim.o.conceallevel = 2

-- change language to english
-- vim.cmd("lan en")

-- dont show built in colorschemes in picker/menu
vim.cmd(
	[[set wildignore+=blue.vim,darkblue.vim,delek.vim,desert.vim,elflord.vim,evening.vim,industry.vim,koehler.vim,lunaperche.vim,morning.vim,murphy.vim,pablo.vim,peachpuff.vim,quiet.vim,retrobox.vim,ron.vim,shine.vim,slate.vim,sorbet.vim,torte.vim,wildcharm.vim,zaibatsu.vim,zellner.vim]]
)
