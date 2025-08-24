#!/usr/bin/env bash

stow -t $HOME alacritty tmux nvim zsh brew starship

BREWFILE=$HOME/.config/homebrew/Brewfile
brew bundle check -v --file $BREWFILE || brew bundle install --file $BREWFILE
