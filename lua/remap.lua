-- Leader --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- exec file
vim.keymap.set("n", "<F9>", ":w <CR> :!manim -pql % <CR> <CR>")
-- vim.keymap.set("n", "<F9>", ":w <CR> :!python % <CR>")
-- vim.keymap.set({ "n", "t" }, "<leader>vv", ":Floaterminal <CR>")

-- Normal Mode --
vim.keymap.set("n", "gw", "vapgw")
vim.keymap.set("n", "<C-q>", "<C-v>")
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader><leader>", ":so<CR>")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "QQ", ":q!<CR>")
vim.keymap.set("n", "WQ", ":wq!<CR>")
vim.keymap.set("n", "WW", ":w!<CR>")
vim.keymap.set({ "n", "v" }, "E", "$")
vim.keymap.set({ "n", "v" }, "B", "0")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "x", [["_x]])
vim.keymap.set("n", "vig", "ggVG")
vim.keymap.set("n", "yig", ":%y<CR>")
vim.keymap.set("n", "dig", ":%d<CR>")

-- Visual Mode --
-- vim.keymap.set("v", "<leader>ss", "Vgw")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]]) -- P macht das gleiche

-- Insert Mode
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true })
-- vim.keymap.set("i", "jk", "<Esc>")
-- vim.keymap.set("i", "kj", "<Esc>")
