#!/usr/bin/env bash

echo "Installing packages"

mise install

GO_PACKAGES=(
  "github.com/joshmedeski/sesh/v2@latest"
  # "github.com/xvzc/SpoofDPI/cmd/spoofdpi@latest"
)
for package in "${GO_PACKAGES[@]}"; do
  go install $package
done

if command -v code; then
  VS_CODE_EXTENSIONS=(
    "golang.Go"
    "ms-python.python"
  )
  for ext in "${VS_CODE_EXTENSIONS[@]}"; do
    code --install-extension $ext
  done
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi
