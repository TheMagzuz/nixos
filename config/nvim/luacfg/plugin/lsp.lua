local lsp = require("lsp-zero")
local mason = require("mason")

--lsp.ensure_installed({
--	"rust_analyzer",
--  "ltex",
--})

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = lsp.cmp_action()

cmp.setup({
  -- completion = {
  --   keyword_length = 1,
  --   keyword_pattern = '.*',
  -- },
  -- sources = {
  --   { name = 'nvim_lsp', keyword_length = 1 },
  -- },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-space>'] = cmp_action.toggle_completion(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-j>'] = cmp_action.luasnip_jump_forward(),
  })
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>qa", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
end)

mason.setup({
  PATH = "append",
})
require('mason-lspconfig').setup({
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      -- (Optional) configure lua language server
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})
