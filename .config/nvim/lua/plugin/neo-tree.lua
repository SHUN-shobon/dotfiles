require("neo-tree").setup {
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      never_show = {
        ".git",
      },
    },
  },
}

vim.api.nvim_set_keymap("n", "[Prefix] ", "<Cmd>Neotree reveal<CR>", { noremap = true, silent = true })
