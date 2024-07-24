require("trouble").setup()

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics<cr>",
  {silent = true, noremap = true, desc = "Open diagnostics"}
)
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics filter.buf=0<cr>",
  {silent = true, noremap = true, desc = "Open buffer diagnostics"}
)
vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references focus<cr>",
  {silent = true, noremap = true, desc = "Go to references"}
)
