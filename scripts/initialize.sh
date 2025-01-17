#!/usr/bin/env bash

# config
asdf_version="v0.9.0"
fzf_version="0.30.0"

set -ue

# shellcheck source=scripts/utils.sh
source "${BASH_SOURCE[0]%/*}/utils.sh"

export PATH="$HOME/.cargo/bin:$PATH"

# Rustのセットアップ
if ! has rustup; then
  curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path -c rust-src
fi

cat <<EOF >"$HOME"/.cargo/config.toml
[build]
rustflags = ["-C", "target-cpu=native"]

[profile.release]
lto = "thin"
codegen-units = 1
EOF

# キャッシュの設定
if ! has sccache; then
  cargo install sccache
fi
RUSTC_WRAPPER="$(which sccache)"
export RUSTC_WRAPPER

# Rust製ツールのインストール
has cargo-add || cargo install cargo-edit
has cargo-watch || cargo install cargo-watch
has lsd || cargo install lsd
has bat || cargo install bat
has rg || cargo install ripgrep
has fd || cargo install fd-find
has delta || cargo install git-delta
has starship || cargo install starship

# Rust Analyzerのインストール
if ! has rust-analyzer; then
  rust_analyzer_dir="$(mktemp -d)"
  git clone --depth=1 https://github.com/rust-analyzer/rust-analyzer.git "$rust_analyzer_dir"
  cd "$rust_analyzer_dir"
  "$HOME"/.cargo/bin/cargo xtask install --server
  cd -
  rm -rf "$rust_analyzer_dir"
fi

# asdfのインストール
if ! has asdf; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "$asdf_version"
  set +ue
  # shellcheck source=/dev/null
  source ~/.asdf/asdf.sh
  set -ue
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf plugin add golang https://github.com/kennyp/asdf-golang.git
  asdf plugin add lua-language-server https://github.com/shun-shobon/asdf-lua-language-server.git
  asdf plugin add direnv https://github.com/asdf-community/asdf-direnv.git
  asdf install
fi

# Node製ツールのインストール
has init yarn || npm install -g yarn
has init pnpm || npm install -g pnpm
has init tsc || npm install -g typescript
has init typescript-language-server || npm install -g typescript-language-server
has init yaml-language-server || npm install -g yaml-language-server
has init vscode-html-language-server || npm install -g vscode-langservers-extracted
has init tailwindcss-language-server || npm install -g @tailwindcss/language-server
has init cssmodules-language-server || npm install -g cssmodules-language-server
has init bash-language-server || npm install -g bash-language-server
has init dockerfile-langserver || npm install -g dockerfile-language-server-nodejs

# Go製ツールのインストール
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"
has lazygit || go install github.com/jesseduffield/lazygit@latest
has ghq || go install github.com/x-motemen/ghq@latest

# fzfのインストール
if ! has fzf; then
  fzf_dir="$(mktemp -d)"
  git clone https://github.com/junegunn/fzf.git "$fzf_dir" --branch "$fzf_version"
  cd "$fzf_dir"
  make
  cp target/fzf-* "$GOBIN/fzf"
  cd -
  rm -rf "$fzf_dir"
fi
