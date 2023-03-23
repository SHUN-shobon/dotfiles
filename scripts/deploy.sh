#!/usr/bin/env bash

set -ue

DOTFILE_DIR="${BASH_SOURCE[0]%/*}/../shared"
cd "$DOTFILE_DIR"

# カレントディレクトリ下の.から始まる.git/下以外のファイルかシンボリックリンクを列挙
find . \( -type f -o -type l \) -print0 | while IFS= read -r -d '' file; do
  file="${file#*/}"
  # リンク元
  link_src="$DOTFILE_DIR/$file"
  # リンク先
  link_dst="$HOME/$file"

  # リンク先のディレクトリ
  link_dir="$(dirname "$link_dst")"
  # ディレクトリが存在しない場合は作成
  if [[ ! -d "$link_dir" ]]; then
    mkdir -p "$link_dir"
  fi

  # すでにシンボリックリンク以外のファイルが存在すればリネームして残す
  if [[ -e "$link_dst" ]] && [[ ! -L "$link_dst" ]]; then
    mv "$link_dst" "$link_dst.old"
    # shellcheck disable=SC2088
    echo "~/$file is renamed to ~/$file.old"
  fi

  # シンボリックリンクを貼る
  ln -fsnv "$link_src" "$link_dst"
done
