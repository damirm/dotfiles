#!/usr/bin/env bash

echo "Installing packages"

mise install

GO_PACKAGES=(
    "github.com/joshmedeski/sesh/v2@latest"
    "github.com/xvzc/SpoofDPI/cmd/spoofdpi@latest"
)
for package in "${GO_PACKAGES[@]}"; do
    go install $package
done

VS_CODE_EXTENSIONS=(
    "golang.Go"
    "ms-python.python"
)
for ext in "${VS_CODE_EXTENSIONS[@]}"; do
    code --install-extension $ext
done
