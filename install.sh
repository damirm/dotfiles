#!/usr/bin/env bash

if command -v brew &>/dev/null; then
    ./install-macos-packages.sh
fi

if command -v dnf &>/dev/null; then
    ./install-fedora-packages.sh
fi

./install-configs.sh
./install-packages.sh
