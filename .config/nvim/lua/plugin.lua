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

-- Packerの設定開始
cmd("packadd packer.nvim")
require("packer").startup(function ()
  use { "wbthomason/packer.nvim", opt = true }

  -- ファイルタイプ別の設定などを追加するプラグイン
  use { "sheerun/vim-polyglot" }

  -- ヘルプの日本語化
  use {
    "vim-jp/vimdoc-ja",
    config = function ()
      -- 参照するヘルプの日本語の優先順位を上げる
      vim.o.helplang = "ja,en"
    end
  }

  -- Nordカラースキーム(Tree-Sitter対応版)
  use {
    "shaunsingh/nord.nvim",
    config = function ()
      -- 背景を透過させる
      vim.g.nord_disable_background = true
      -- ウィンドウの区切り線を表示
      vim.g.nord_borders = true

      require("nord").set()
    end
  }

  -- ステータスライン
  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      { "kyazdani42/nvim-web-devicons", opt = true },
      "shaunsingh/nord.nvim"
    },
    config = function ()
      require("lualine").setup {
        options = {
          -- カラースキームをNordに変更
          theme = "nord",
        }
      }
    end
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function ()
      require("nvim-treesitter.configs").setup {
        -- 全言語有効にする
        ensure_installed = "all",
        -- シンタックスハイライトを有効
        highlight = { enable = true },
      }
    end
  }

  -- 囲い込み系キーバインドの強化
  use {
    "ur4ltz/surround.nvim",
    requires = { "tpope/vim-repeat" },
    config = function ()
      require("surround").setup {
        mappings_style = "surround",
      }
    end
  }

  -- 自動囲い込み閉じ
  use {
    "windwp/nvim-autopairs",
    config = function ()
      require("nvim-autopairs").setup {
        enable_check_bracket_line = true,
      }
    end
  }
end)
