#!/usr/bin/env bash
# run_once_setup_flatpak.sh
# Flatpak setup for Linux

set -e

echo "==> Setting up Flatpak..."

# Check if flatpak is available
if ! command -v flatpak &> /dev/null; then
  echo "Flatpak not found, skipping..."
  exit 0
fi

# Add Flathub repository
echo "Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install applications
echo "Installing Flatpak applications..."

FLATPAK_APPS=(
  com.mattjakeman.ExtensionManager
  eu.betterbird.Betterbird
  org.videolan.VLC
  org.telegram.desktop
  com.visualstudio.code
  md.obsidian.Obsidian
  com.transmissionbt.Transmission
  com.jetbrains.IntelliJ-IDEA-Community
  com.todoist.Todoist
  org.localsend.localsend_app
  io.github.kolunmi.Bazaar
  io.gitlab.adhami3310.Impression
)

for app in "${FLATPAK_APPS[@]}"; do
  echo "Installing $app..."
  flatpak install -y flathub "$app" || echo "Failed to install $app, continuing..."
done

echo "==> Flatpak setup complete!"
