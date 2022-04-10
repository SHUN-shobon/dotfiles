# エイリアスの設定
alias ls='lsd -F'
alias ll='ls -l'
alias la='ls -al'
alias cat='bat'
alias g='git'
alias d='docker'
alias e='nvim'

# asdfの設定
source ~/.asdf/asdf.sh

# 補完の有効化
autoload -Uz compinit && compinit -i
