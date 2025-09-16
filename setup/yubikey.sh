#!/usr/bin/env bash

# Setup yubikey
if lsusb | grep -i yubikey; then
  if [ ! -f ~/.config/Yubico/u2f_keys ]; then
    mkdir -p ~/.config/Yubico
    echo "Touch yubikey: "
    pamu2fcfg > ~/.config/Yubico/u2f_keys
    sudo authselect select local
    sudo authselect enable-feature with-pam-u2f
    sudo authselect apply-changes
  fi
fi
