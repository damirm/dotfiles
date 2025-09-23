#!/usr/bin/env bash

# TODO: Move that to homelab.
# Install byedpi
if ! command -v ciadpi &> /dev/null; then
  tmp_dir=$(mktemp -d)
  remote_zip="https://github.com/hufrea/byedpi/releases/download/v0.17.2/byedpi-17.2-x86_64.tar.gz"
  file_name=$(basename "$remote_zip")
  wget -P "$tmp_dir" "$remote_zip"
  tar zxvf "$tmp_dir/$file_name" -C "$tmp_dir"
  mkdir -p "$HOME/.local/bin"
  mv "$tmp_dir/ciadpi-x86_64" "$HOME/.local/bin/ciadpi"
  user_systemd_dir="$HOME/.config/systemd/user"
  mkdir -p "$user_systemd_dir"
  ln -s $(pwd)/fedora/home/.config/systemd/user/byedpi.service "$user_systemd_dir/byedpi.service"
  systemctl --user daemon-reload
  systemctl --user enable byedpi.service
  systemctl --user start byedpi.service
fi
