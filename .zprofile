# XDG Base Directoryの設定
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# 言語の設定
export LANG="en_US.UTF-8"

# editorの設定
export EDITOR="nvim"

# pagerの設定
export PAGER="less"
export LESS="-iRSL -x4 -z-4 -j.5"

# Golangの設定
export GOPATH="$XDG_DATA_HOME/go"

# PATHの設定
path=(
  $GOPATH/bin(N-/)
  $HOME/.cargo/bin(N-/)
  $path
)
