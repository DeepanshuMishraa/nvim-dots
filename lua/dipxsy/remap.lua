vim.g.mapleader = " "
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

-- Ctrl+S to save and go to normal mode
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>")

-- Ctrl+A to select all
vim.keymap.set("n", "<C-a>", "ggVG")
