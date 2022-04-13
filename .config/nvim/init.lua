-- 一部関数にエイリアスを貼る
local fn = vim.fn
local cmd = vim.cmd

-- autocmdの設定
cmd("augroup init")
cmd("autocmd!")
cmd("augroup END")

-- バッファやレジスタ内で使用する文字コードを指定
vim.o.encoding = "utf-8"

-- 既存ファイルを開くときにVimが使用する文字コードを判定する順番を指定
vim.o.fileencodings = "utf-8,iso-2033-jp,enc-jp,sjis"

-- viminfoファイルの出力先を変更
vim.o.viminfo = vim.o.viminfo .. ",n" .. fn.stdpath("cache") .. "/info"

-- Undo履歴を永続化
vim.o.undodir = fn.stdpath("cache") .. "/undo"
vim.bo.undofile = true

-- Swapファイルの出力先を変更
vim.o.wildmenu = true
-- 補完の仕方を始めに最長共通文字列を補完し、次に完全に補完
vim.o.wildmode = "longest,full"

-- 行番号を表示
vim.wo.number = true

-- スクロールにオフセットを持たせる
vim.wo.scrolloff = 5

-- 自動改行を無効化
vim.bo.textwidth = 0

-- 不可視文字を表示
vim.wo.list = true
-- 不可視文字のスタイルを変更
vim.o.listchars = "tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↵"

-- カーソルラインを表示
vim.wo.cursorline = true

-- タブラインを常に表示
vim.o.showtabline = 2

-- 検索結果を自動ハイライト
vim.o.hlsearch = true

-- 検索時のみ大文字小文字を区別しない
cmd("autocmd init CmdlineEnter [/?] set ignorecase")
cmd("autocmd init CmdlineLeave [/?] set noignorecase")

-- 大文字が含まれる場合は区別する
vim.o.smartcase = true

-- インクリメンタルサーチを有効化
vim.o.incsearch = true

-- バックスラッシュやエクステンションを自動エスケープ
vim.api.nvim_set_keymap(
  "c",
  "/",
  "getcmdtype() == '/' ? '\\/' : '/'",
  { noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
  "c",
  "?",
  "getcmdtype() == '?' ? '\\?' : '?'",
  { noremap = true, expr = true }
)

-- 手動インデント時に"shiftwidth"の倍数に丸める
vim.o.shiftround = true

-- 矩形選択時にテキストが存在しない部分でも選択できるようにする
vim.o.virtualedit = "block"

-- バッファを閉じずに隠す
vim.o.hidden = true

-- ファイルを新しく開く代わりにすでに開いてあるバッファを使用する
vim.o.switchbuf = "useopen"

-- 対応する括弧をハイライト表示する
vim.o.showmatch = true
-- ハイライト表示の時間を設定
vim.o.matchtime = 2

-- バックスラッシュで何でも消せるようにする
vim.o.backspace = "indent,eol,start"

-- タブをスペースに展開
vim.bo.expandtab = true

-- インデントを考慮して改行する
vim.bo.smartindent = true

-- 補完の仕方を変更
vim.o.completeopt = "menuone,noinsert,noselect"

-- 補完時にメッセージを出さない
vim.o.shortmess = vim.o.shortmess .. "c"

-- 挿入モード中にjjで<Esc>
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })

-- [Prefix]というマッピングを追加
vim.api.nvim_set_keymap("n", "[Prefix]", "", { noremap = true })
-- <Space>に[Prefix]を割り当て
vim.api.nvim_set_keymap("n", "<Space>", "[Prefix]", {})

-- <Esc>x2でハイライトオフ
vim.api.nvim_set_keymap(
  "n",
  "<Esc><Esc>",
  "<Cmd>nohlsearch<CR>",
  { noremap = true, silent = true }
)

-- 検索結果を画面中央に表示
vim.api.nvim_set_keymap("n", "n", "nzz", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzz", { noremap = true })
vim.api.nvim_set_keymap("n", "*", "*zz", { noremap = true })
vim.api.nvim_set_keymap("n", "#", "#zz", { noremap = true })
vim.api.nvim_set_keymap("n", "g*", "g*zz", { noremap = true })
vim.api.nvim_set_keymap("n", "g#", "g#zz", { noremap = true })

-- 表示行でj, k移動
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = true })

-- vx2で行末まで選択
vim.api.nvim_set_keymap("v", "v", "$h", { noremap = true })

-- Ctrl + hjklでウィンドウ間移動
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true })
-- Ctrl + 矢印キーでウィンドウリサイズ
vim.api.nvim_set_keymap("n", "<S-Left>",  "<C-w><", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Down>",  "<C-w>+", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Up>",    "<C-w>-", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Right>", "<C-w>>", { noremap = true })

-- QuickFix及びHelpではqで閉じる
cmd("autocmd init FileType help,qf nnoremap <buffer> q <C-w>c")

-- w!!でスーパーユーザーとして保存
vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee > /dev/null %", {})

-- H, Lで行頭、行末へ移動
vim.api.nvim_set_keymap("n", "H", "^", { noremap = true })
vim.api.nvim_set_keymap("n", "L", "$", { noremap = true })

-- [Prefix] + tでターミナルを開く
vim.api.nvim_set_keymap(
  "n",
  "[Prefix]t",
  "<Cmd>botright 20split +term<CR>i",
  { noremap = true, silent = true }
)

-- make, grepなどのコマンドの後に自動的にQuickFixを開く
cmd("autocmd init QuickfixCmdPost make,grep,grepadd,vimgrep copen")

-- フォルダが存在しない場合に自動作成する
function mkdir(dir, force)
  if fn.isdirectory(dir) and (force or string.match(fn.input(fn.printf('"%s" does not exist. Create? [y/N]', dir)), "^y(es)?$")) then
    fn.mkdir(dir, "p")
  end
end
cmd("autocmd init BufWritePre * call v:lua.mkdir(expand('<afile>:p:h'), v:cmdbang)")


-- プラグインの設定
-- Packer.nvimが無ければ自動インストールする
local packer_dir = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(packer_dir)) > 0 then
  cmd("!git clone --depth=1 https://github.com/wbthomason/packer.nvim " .. packer_dir)
end

-- このファイル編集時に設定再読み込み
cmd("autocmd init BufWritePost " .. fn.stdpath("config") .. "/init.lua source " .. fn.stdpath("config") .. "/init.lua | PackerCompile")

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
