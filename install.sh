#!/usr/bin/env bash

stow -t $HOME alacritty tmux nvim zsh brew starship kitty

if command -v brew >/dev/null 2>&1; then
    BREWFILE=$HOME/.config/homebrew/Brewfile
    brew bundle check -v --file $BREWFILE || brew bundle install --file $BREWFILE
fi
