#!/usr/bin/env bash

echo "Enable dnf repositories..."
sudo dnf copr enable -y jdxcode/mise
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y dejan/lazygit

echo "Installing packages..."
sudo dnf install -y stow zsh nvim mise ripgrep tmux uv ruff starship lazygit fzf zoxide xclip

echo "Installing gnome settings..."
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_shifted_capslock']"
