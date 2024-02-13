require("neodev").setup({
  override = function(root_dir, library)
    if root_dir:find(vim.fn.expand("~/flake"), 1, true) == 1 then
      library.enabled = true
      library.plugins = true
    end
  end,
})

local lsp = require("lsp-zero")
local cfg = require("lspconfig")

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = lsp.cmp_action()

cmp.setup({
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
  vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, opts)
  vim.keymap.set("n", "<leader>qa", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
end)

cfg.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
	disable = { 'missing-fields' }
      }
    }
  }
})

cfg.rust_analyzer.setup({})
cfg.nil_ls.setup({})
cfg.texlab.setup({})
