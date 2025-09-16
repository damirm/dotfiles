#!/usr/bin/env bash

if command -v brew &> /dev/null; then
  brew install stow
fi

if command -v dnf &> /dev/null; then
  ./install-fedora-packages.sh
fi

echo "Creating symlinks..."
stow -t $HOME alacritty tmux nvim zsh brew starship kitty sesh mise git terraform scripts

if command -v brew &> /dev/null; then
  echo "Installing brew packages..."
  BREWFILE="$HOME/.config/homebrew/Brewfile"
  brew bundle check -v --file $BREWFILE || brew bundle install --file $BREWFILE
fi

./install-packages.sh
