#!/usr/bin/env bash

# TODO:
# - Remap caps_lock to left_control

# xcode-select --install
# sudo xcodebuild -license accept

# Enable dark theme.
defaults write .GlobalPreferences AppleInterfaceStyle -string "Dark"

# Setup dock.
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock "tilesize" -int "36"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-time-modifier" -float "0.5"
defaults write com.apple.dock "autohide-delay" -float "0"

# defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true"
# defaults write com.apple.Safari "IncludeInternalDebugMenu" -bool true

# Enable safari developer tools.
defaults write -g "WebKitDeveloperExtras" -bool true

# Setup finder.
defaults write -g "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "_FXShowPosixPathInTitle" -bool true
defaults write com.apple.finder "FXPreferredViewStyle" -string "nlsv"

# Setup clock.
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\""
defaults write com.apple.HIToolbox "AppleFnUsageType" -int "0"

# TODO: Why it doesn't work?
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# Setup menu bar icons.
defaults -currentHost write com.apple.controlcenter Bluetooth -int 18
defaults -currentHost write com.apple.controlcenter Sound -int 18
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

# Remove TimeMachine menu bar icon.
# defaults delete "com.apple.systemuiserver" "NSStatusItem Preferred Position com.apple.menuextra.TimeMachine"
# defaults delete "com.apple.systemuiserver" "NSStatusItem Visible com.apple.menuextra.TimeMachine"

# defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false              # For VS Code
# defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false      # For VS Code Insider
# defaults write com.vscodium ApplePressAndHoldEnabled -bool false                      # For VS Codium
# defaults write com.microsoft.VSCodeExploration ApplePressAndHoldEnabled -bool false   # For VS Codium Exploration users
# defaults write com.exafunction.windsurf ApplePressAndHoldEnabled -bool false          # For Windsurf
# defaults delete -g ApplePressAndHoldEnabled
