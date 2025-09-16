#!/usr/bin/env bash

function install_nerd_font {
  local font_name="$1"
  local remote_file="$2"
  local zip_file=$(basename $remote_file)
  local tmp_dir="/tmp"
  local dst_dir=$HOME/.local/share/fonts

  if fc-list | grep -q "$font_name"; then
    echo "Font $font_name is already exists, skipping..."
    return 0
  fi

  echo "Installing font from $remote_file..."
  wget -P $tmp_dir $remote_file
  mkdir -p $dst_dir
  unzip -o $tmp_dir/$zip_file -d $dst_dir
  sudo fc-cache -v
  rm $tmp_dir/$zip_file
}

install_nerd_font "JetBrainsMono" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
