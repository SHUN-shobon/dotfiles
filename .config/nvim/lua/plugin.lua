local fn = vim.fn
local cmd = vim.cmd

-- プラグインの設定
-- Packer.nvimが無ければ自動インストールする
local packer_dir = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(packer_dir)) > 0 then
  cmd("!git clone --depth=1 https://github.com/wbthomason/packer.nvim " .. packer_dir)
end

-- このファイル編集時に設定再読み込み
cmd("autocmd init BufWritePost .config/nvim/lua/plugin.lua source <afile> | PackerCompile")

-- 設定ファイル読み込み用関数
local load = function(name)
  return 'require("plugin/' .. name ..'")'
end

-- Packerの設定開始
cmd("packadd packer.nvim")
require("packer").startup(function ()
  use { "wbthomason/packer.nvim", opt = true }

  -- ファイルタイプ別の設定などを追加するプラグイン
  use { "sheerun/vim-polyglot" }

  -- ヘルプの日本語化
  use { "vim-jp/vimdoc-ja", config = load("vimdoc-ja") }

  -- Nordカラースキーム(Tree-Sitter対応版)
  use { "shaunsingh/nord.nvim", config = load("nord") }

  -- ステータスライン
  use {
    "nvim-lualine/lualine.nvim",
    -- nord.nvimの前に読み込むとthemeが壊れるのでnord.nvimが読み込まれると読み込むようにする
    after = "nord.nvim",
    requires = {
      { "kyazdani42/nvim-web-devicons", opt = true },
      { "SmiteshP/nvim-gps" },
    },
    config = load("lualine"),
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = load("nvim-treesitter"),
  }

  -- 今いる関数名を表示する
  use {
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
    config = load("nvim-gps"),
  }

  -- 関数の引数だけ色を変える
  use {
    "m-demare/hlargs.nvim",
    after = "nord.nvim",
    requires = "nvim-treesitter/nvim-treesitter",
    config = load("hlargs"),
  }

  -- 囲い込み系キーバインドの強化
  use {
    "ur4ltz/surround.nvim",
    requires = { "tpope/vim-repeat" },
    config = load("surround"),
  }

  -- 自動囲い込み閉じ
  use { "windwp/nvim-autopairs", config = load("nvim-autopairs") }

  -- ファイルツリー
  use {
    "nvim-neo-tree/neo-tree.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = load("neo-tree"),
  }

  -- Gitの状態表示
  use { "lewis6991/gitsigns.nvim", config = load("gitsigns") }

  -- 検索の表示を良くする
  use { "kevinhwang91/nvim-hlslens", config = load("nvim-hlslens") }

  -- スクロールバー
  use { "petertriho/nvim-scrollbar", config = load("nvim-scrollbar") }

  -- WakaTime
  use { "wakatime/vim-wakatime" }

  -- 補完
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind-nvim",
    },
    config = load("nvim-cmp"),
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = load("nvim-lspconfig"),
  }

  -- LSPの見た目を良くする
  use { "tami5/lspsaga.nvim", config = load("lspsaga") }
  use { "folke/lsp-colors.nvim", config = load("lsp-colors") }

  -- LSPのステータスを表示する
  use { "j-hui/fidget.nvim", config = load("fidget") }
end)
