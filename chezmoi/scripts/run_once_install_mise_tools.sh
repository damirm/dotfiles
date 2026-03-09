#!/usr/bin/env bash
# run_once_install_mise_tools.sh
# Install tools via mise

set -e

echo "==> Installing tools via mise..."

# Install mise tools from config.toml
if command -v mise &> /dev/null; then
  echo "Installing mise tools..."
  mise install
else
  echo "mise not found, skipping..."
fi

# Install Go packages
if command -v go &> /dev/null; then
  echo "Installing Go packages..."

  GO_PACKAGES=(
    "github.com/joshmedeski/sesh/v2@latest"
    "golang.org/x/tools/cmd/goimports@latest"
  )

  for package in "${GO_PACKAGES[@]}"; do
    if ! command -v "$(basename $package | cut -d'/' -f3)" &> /dev/null; then
      echo "Installing $package..."
      go install "$package"
    else
      echo "$(basename $package | cut -d'/' -f3) already installed, skipping..."
    fi
  done
else
  echo "Go not found, skipping Go packages..."
fi

echo "==> Mise tools installation complete!"
