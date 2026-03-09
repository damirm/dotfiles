#!/usr/bin/env bash
# run_once_install_fonts.sh
# Install fonts for different operating systems

set -e

echo "==> Installing fonts..."

if [[ $(uname -s) == 'Darwin' ]]; then
  # macOS - install via Homebrew
  if command -v brew &> /dev/null; then
    echo "Installing fonts via Homebrew..."
    brew install --cask font-jetbrains-mono || true
    brew install --cask font-jetbrains-mono-nerd-font || true
  fi

elif [[ $(uname -s) == 'Linux' ]]; then
  # Linux - install via package manager
  if command -v dnf &> /dev/null; then
    echo "Installing fonts via DNF..."
    sudo dnf install -y jetbrains-mono-fonts-all || true
    sudo dnf install -y jetbrains-mono-nl-fonts || true
  elif command -v apt &> /dev/null; then
    echo "Installing fonts via APT..."
    sudo apt install -y fonts-jetbrains-mono || true
  fi
fi

echo "==> Fonts installation complete!"
