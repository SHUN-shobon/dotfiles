local fn = vim.fn
local cmd = vim.cmd

-- プラグインの設定
-- Packer.nvimが無ければ自動インストールする
local packer_dir = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(packer_dir)) > 0 then
  cmd("!git clone --depth=1 https://github.com/wbthomason/packer.nvim " .. packer_dir)
end

-- このファイル編集時に設定再読み込み
cmd("autocmd init BufWritePost " .. fn.stdpath("config") .. "/init.lua source <afile> | PackerCompile")

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
    requires = {
      { "kyazdani42/nvim-web-devicons", opt = true },
      "shaunsingh/nord.nvim"
    },
    config = load("lualine"),
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = load("nvim-treesitter"),
  }

  -- 囲い込み系キーバインドの強化
  use {
    "ur4ltz/surround.nvim",
    requires = { "tpope/vim-repeat" },
    config = load("surround"),
  }

  -- 自動囲い込み閉じ
  use { "windwp/nvim-autopairs", config = load("nvim-autopairs") }
end)
