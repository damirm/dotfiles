#!/usr/bin/env bash

echo "Installing packages"

mise install

GO_PACKAGES=(
  "github.com/joshmedeski/sesh/v2@latest"
  "golang.org/x/tools/cmd/goimports@latest"
  # "github.com/xvzc/SpoofDPI/cmd/spoofdpi@latest"
)
for package in "${GO_PACKAGES[@]}"; do
  go install $package
done
