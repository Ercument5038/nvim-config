-- Leader --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>e", ":Ex<CR>", {})
-- Manim Run
--vim.keymap.set("n", "<F9>", ":w <CR> :!manim -pql % <CR> <CR>")

-- Normal Mode --
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<C-q>", "<C-v>")
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader><leader>", ":so<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "QQ", ":q!<CR>")
vim.keymap.set("n", "WW", ":w!<CR>")
vim.keymap.set("n", "E", "$")
vim.keymap.set("n", "B", "0")
vim.keymap.set("n", "<C-a>", "ggVG")
-- vim.keymap.set("n", "<F9>", ":!python3 % <CR>")

-- Visual Mode --
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", [["_dP]])

-- Insert Mode
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true })
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
