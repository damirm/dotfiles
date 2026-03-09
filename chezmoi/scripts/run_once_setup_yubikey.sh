#!/usr/bin/env bash
# run_once_setup_yubikey.sh
# YubiKey setup

set -e

echo "==> Setting up YubiKey..."

# Check if YubiKey is connected
if ! lsusb 2> /dev/null | grep -i yubikey; then
  echo "YubiKey not detected, skipping..."
  exit 0
fi

# Check if running on Linux
if [[ $(uname -s) != 'Linux' ]]; then
  echo "Not running on Linux, skipping..."
  exit 0
fi

# Setup U2F keys
if [ ! -f ~/.config/Yubico/u2f_keys ]; then
  echo "Setting up U2F keys..."
  mkdir -p ~/.config/Yubico
  echo "Touch YubiKey when prompted:"
  pamu2fcfg > ~/.config/Yubico/u2f_keys

  # Configure authselect for Fedora
  if command -v authselect &> /dev/null; then
    echo "Configuring authselect..."
    sudo authselect select local
    sudo authselect enable-feature with-pam-u2f
    sudo authselect apply-changes
  fi
else
  echo "U2F keys already configured, skipping..."
fi

echo "==> YubiKey setup complete!"
