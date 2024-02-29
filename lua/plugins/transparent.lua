return {
    "xiyaowong/transparent.nvim",
    config = function()
        vim.keymap.set("n", "<leader>tt", ":TransparentToggle <CR>")
    end
}
