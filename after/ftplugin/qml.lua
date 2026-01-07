-- Force disable any "clever" indentation (which is currently breaking it)
vim.bo.indentexpr = ""

-- Enable C-style indentation (Best for { } blocks)
vim.bo.cindent = true

-- Ensure basic autoindent is on as a fallback
vim.bo.autoindent = true

-- Optional: Set standard 4-space indent for QML
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

-- DEBUG: Uncomment the line below and restart.
-- If you see this message when opening a QML file, the file is loading correctly.
print("Loaded custom QML indentation settings")
