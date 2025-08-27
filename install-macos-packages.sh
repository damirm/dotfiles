#!/usr/bin/env bash

echo "Installing brew packages..."
BREWFILE="$HOME/.config/homebrew/Brewfile"
brew bundle check -v --file $BREWFILE || brew bundle install --file $BREWFILE
