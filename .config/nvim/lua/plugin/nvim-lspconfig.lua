local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function (client, bufnr)
  local buf_set_keymap = function (...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gx", "<Cmd>Lspsaga code_action<CR>", opts)
  buf_set_keymap("x", "gx", "<Cmd>Lspsaga range_code_action<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
  buf_set_keymap("n", "[Prefix]r", "<Cmd>Lspsaga rename<CR>", opts)
  buf_set_keymap("n", "[Prefix]e", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
  buf_set_keymap("n", "[Prefix]]", "<Cmd>Lspsaga diagnostics_jump_next<CR>", opts)
  buf_set_keymap("n", "[Prefix][", "<Cmd>Lspsaga diagnostics_jump_prev<CR>", opts)
end

lspconfig.rust_analyzer.setup { on_attach = on_attach, capabilities = capabilities }