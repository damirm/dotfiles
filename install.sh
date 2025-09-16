#!/usr/bin/env bash

# TODO: Brewfile does not exist until stow is symlinked it.
# It's required to install stow first, then symlink configs,
# and only then install the rest of brew packages.
if command -v brew &> /dev/null; then
  echo "Installing brew packages..."
  BREWFILE="$HOME/.config/homebrew/Brewfile"
  brew bundle check -v --file $BREWFILE || brew bundle install --file $BREWFILE
fi

if command -v dnf &> /dev/null; then
  ./install-fedora-packages.sh
fi

echo "Creating symlinks..."
stow -t $HOME alacritty tmux nvim zsh brew starship kitty sesh mise git terraform scripts

./install-packages.sh
