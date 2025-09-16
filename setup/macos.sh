#!/usr/bin/env bash

# TODO:
# - Remap caps_lock to left_control

xcode-select --install
sudo xcodebuild -license accept

defaults write .GlobalPreferences AppleInterfaceStyle -string "Dark"

defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock "tilesize" -int "36"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-time-modifier" -float "0.5"
defaults write com.apple.dock "autohide-delay" -float "0"

defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true"
defaults write com.apple.Safari "IncludeInternalDebugMenu" -bool true
defaults write NSGlobalDomain "WebKitDeveloperExtras" -bool true

defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "_FXShowPosixPathInTitle" -bool true
defaults write com.apple.finder "FXPreferredViewStyle" -string "nlsv"

defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\""
defaults write com.apple.HIToolbox "AppleFnUsageType" -int "0"

defaults write NSGlobalDomain "KeyRepeat" -int 1

defaults -currentHost write com.apple.controlcenter Bluetooth -int 18
defaults -currentHost write com.apple.controlcenter Sound -int 18
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true
