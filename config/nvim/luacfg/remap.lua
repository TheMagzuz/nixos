
vim.keymap.set("i", "jk", "<esc>")
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader>pv", function() vim.cmd.Ex(".") end)

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("i", "<leader>oe", "ø")
vim.keymap.set("i", "<leader>ae", "æ")
vim.keymap.set("i", "<leader>aa", "å")

vim.keymap.set("n", "<leader>n", function() vim.cmd("noh") end)

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
