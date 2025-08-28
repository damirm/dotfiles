#!/usr/bin/env bash

echo "Installing packages"
mise install
go install github.com/joshmedeski/sesh/v2@latest

code --install-extension golang.Go
code --install-extension ms-python.python
