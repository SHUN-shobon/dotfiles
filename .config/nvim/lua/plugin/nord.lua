-- 背景を透過させる
vim.g.nord_disable_background = true
-- カーソルラインを透過させる
vim.g.nord_cursorline_transparent = true
-- ウィンドウの区切り線を表示
vim.g.nord_borders = true

require("nord").set()

local colors = require("nord.colors")
-- 不可視文字やバーチャルテキストをもう少し見やすくする
vim.cmd("highlight NonText guifg=" .. colors.nord3_gui)
