-- autocmdの設定
vim.cmd [[
	augroup init
  autocmd!
  augroup END
]]

-- オプション
require("option")
-- キーバインド
require("keybind")
-- プラグイン
require("plugin")
