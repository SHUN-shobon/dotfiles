# XDG Base Directoryの設定
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"

# 言語の設定
export LANG="en_US.UTF-8"

# editorの設定
export EDITOR="nvim"

# pagerの設定
export PAGER="less"
export LESS="-iRSL -x4 -z-4 -j.5"

# SSHの設定
# gpg-agentを起動
gpg-connect-agent --quiet /bye
# ssh-agentのソケットファイルをgpg-agentに変更する
SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# Golangの設定
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$XDG_BIN_HOME"

# PATHの設定
path=(
  /usr/local/texlive/2022/bin/universal-darwin(N-/)
  /usr/local/opt/llvm/bin(N-/)
  $XDG_BIN_HOME(N-/)
  $HOME/.cargo/bin(N-/)
  $HOME/.deno/bin(N-/)
  $HOME/.cabal/bin(N-/)
  $HOME/.ghcup/bin(N-/)
  $path
)

# clangだけ元のものを使用する
alias clang="/usr/bin/clang"
