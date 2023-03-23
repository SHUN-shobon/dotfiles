local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("o", "iu", [[<Cmd>lua require"treesitter-unit".select()<CR>]], opts)
vim.api.nvim_set_keymap("o", "au", [[<Cmd>lua require"treesitter-unit".select(true)<CR>]], opts)
vim.api.nvim_set_keymap("v", "iu", [[:<C-u>lua require"treesitter-unit".select()<CR>]], opts)
vim.api.nvim_set_keymap("v", "au", [[:<C-u>lua require"treesitter-unit".select(true)<CR>]], opts)
