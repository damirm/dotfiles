#!/usr/bin/env bash

if command -v brew &> /dev/null; then
  brew install stow
fi

if command -v dnf &> /dev/null; then
  ./setup/dnf.sh
  ./setup/fedora.sh
fi

if command -v gsettings &> /dev/null; then
  ./setup/gnome.sh
fi

if command -v flatpak &> /dev/null; then
  ./setup/flatpak.sh
fi

if command -v fc-cache &> /dev/null; then
  ./setup/fonts.sh
fi

./setup/yubikey.sh

echo "Creating symlinks..."
stow -t $HOME alacritty tmux nvim zsh brew starship kitty sesh mise terraform scripts ssh git

if command -v brew &> /dev/null; then
  echo "Installing brew packages..."
  BREWFILE="$HOME/.config/homebrew/Brewfile"
  brew bundle check -v --file $BREWFILE || brew bundle install --file $BREWFILE
fi

[[ $OSTYPE == 'darwin'* ]] && ./setup/macos.sh

./setup/packages.sh
