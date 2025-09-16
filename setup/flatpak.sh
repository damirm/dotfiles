#!/usr/bin/env bash

echo "Installing flatpak packages..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub \
  com.mattjakeman.ExtensionManager \
  eu.betterbird.Betterbird \
  org.videolan.VLC \
  org.telegram.desktop \
  com.visualstudio.code \
  md.obsidian.Obsidian \
  com.transmissionbt.Transmission \
  com.jetbrains.IntelliJ-IDEA-Community \
  com.visualstudio.code \
  com.todoist.Todoist \
  org.localsend.localsend_app

# org.mozilla.Thunderbird
