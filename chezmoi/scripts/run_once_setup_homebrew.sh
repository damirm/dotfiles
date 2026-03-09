#!/usr/bin/env bash
# run_once_setup_homebrew.sh
# Homebrew setup for macOS and Linux

set -e

echo "==> Setting up Homebrew..."

# Check if brew is available
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found, skipping..."
  exit 0
fi

# Install brew packages from Brewfile
BREWFILE="$(pwd)/dotfiles/.config/homebrew/Brewfile"

if [ -f "$BREWFILE" ]; then
  echo "Installing brew packages from $BREWFILE..."
  brew bundle check -v --file "$BREWFILE" || brew bundle install --file "$BREWFILE"
else
  echo "Brewfile not found at $BREWFILE, skipping..."
fi

echo "==> Homebrew setup complete!"
