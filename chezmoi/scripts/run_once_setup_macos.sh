#!/usr/bin/env bash
# run_once_setup_macos.sh
# macOS-specific setup

set -e

echo "==> Setting up macOS..."

# Check if running on macOS
if [[ $(uname -s) != 'Darwin' ]]; then
  echo "Not running on macOS, skipping..."
  exit 0
fi

# Enable dark theme
echo "Enabling dark theme..."
defaults write .GlobalPreferences AppleInterfaceStyle -string "Dark"

# Setup dock
echo "Setting up dock..."
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock "tilesize" -int "36"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-time-modifier" -float "0.5"
defaults write com.apple.dock "autohide-delay" -float "0"

# Enable Safari developer tools
echo "Enabling Safari developer tools..."
defaults write -g "WebKitDeveloperExtras" -bool true

# Setup finder
echo "Setting up finder..."
defaults write -g "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "_FXShowPosixPathInTitle" -bool true
defaults write com.apple.finder "FXPreferredViewStyle" -string "nlsv"

# Setup clock
echo "Setting up clock..."
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\""
defaults write com.apple.HIToolbox "AppleFnUsageType" -int "0"

# Key repeat settings
echo "Setting up keyboard..."
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# Setup menu bar icons
echo "Setting up menu bar..."
defaults -currentHost write com.apple.controlcenter Bluetooth -int 18
defaults -currentHost write com.apple.controlcenter Sound -int 18
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

# Restart dock
echo "Restarting Dock..."
killall Dock

echo "==> macOS setup complete!"
echo "Note: Some changes require logout/login to take effect."
