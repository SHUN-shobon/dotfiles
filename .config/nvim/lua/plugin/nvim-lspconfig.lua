local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
  local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
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

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end
end

-- C / C++
lspconfig.clangd.setup { on_attach = on_attach, capabilities = capabilities }
-- Rust
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      procMacro = { enable = true },
      checkOnSave = { command = "clippy" },
    },
  },
}
-- LaTeX
lspconfig.texlab.setup { on_attach = on_attach, capabilities = capabilities }
-- Haskell
lspconfig.hls.setup { on_attach = on_attach, capabilities = capabilities }
-- HTML
lspconfig.html.setup { on_attach = on_attach, capabilities = capabilities }
-- CSS / SCSS / Less
lspconfig.cssls.setup { on_attach = on_attach, capabilities = capabilities }
-- CSS Module
lspconfig.cssmodules_ls.setup { on_attach = on_attach, capabilities = capabilities }
-- TailwindCSS
lspconfig.tailwindcss.setup { on_attach = on_attach, capabilities = capabilities }
-- JSON
lspconfig.jsonls.setup { on_attach = on_attach, capabilities = capabilities }
-- YAML
lspconfig.yamlls.setup { on_attach = on_attach, capabilities = capabilities }
-- Bash
lspconfig.bashls.setup { on_attach = on_attach, capabilities = capabilities }
-- Lua
-- TODO: Dotfiles専用の設定にしたい
-- Neovim専用設定
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}

-- TypeScript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("package.json")
}
lspconfig.denols.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("mod.ts")
}
