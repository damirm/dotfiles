#!/usr/bin/env bash
# run_once_install_oh-my-zsh.sh
# Install Oh My Zsh

set -e

echo "==> Installing Oh My Zsh..."

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
else
  echo "Oh My Zsh already installed, skipping..."
fi

echo "==> Oh My Zsh installation complete!"
echo "Note: Plugins are managed by chezmoi external (.chezmoiexternal.toml)"
