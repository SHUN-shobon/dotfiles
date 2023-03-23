local gps = require("nvim-gps")

require("lualine").setup {
  options = {
    -- カラースキームをNordに変更
    theme = "nord",
  },
  sections = {
    lualine_c = {
      { gps.get_location, cond = gps.is_available }
    }
  }
}
