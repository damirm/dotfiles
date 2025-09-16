#!/usr/bin/env bash

if command -v brew &> /dev/null; then
  brew install stow
fi

if command -v dnf &> /dev/null; then
  echo "Configuring dnf..."
  ./setup/dnf.sh

  echo "Configuring fedora..."
  ./setup/fedora.sh
fi

if command -v gsettings &> /dev/null; then
  echo "Configuring gnome..."
  ./setup/gnome.sh
fi

if command -v flatpak &> /dev/null; then
  echo "Configuring flatpak..."
  ./setup/flatpak.sh
fi

if command -v fc-cache &> /dev/null; then
  echo "Configuring fonts..."
  ./setup/fonts.sh
fi

if command -v lsusb &> /dev/null; then
  ./setup/yubikey.sh
fi

echo "Configuring dotfiles..."
# TODO: Temporary disable scripts, ssh, git dotfiles.
stow -t $HOME alacritty tmux nvim zsh brew starship kitty sesh mise terraform # scripts ssh git

if command -v brew &> /dev/null; then
  echo "Configuring homebrew..."
  ./setup/brew.sh
fi

[[ $OSTYPE == 'darwin'* ]] && ./setup/macos.sh

./setup/packages.sh
