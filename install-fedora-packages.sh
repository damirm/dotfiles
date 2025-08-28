#!/usr/bin/env bash

echo "Enable dnf repositories..."
sudo dnf copr enable -y jdxcode/mise
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y dejan/lazygit

echo "Installing packages..."
sudo dnf install -y stow zsh nvim mise ripgrep tmux uv ruff starship lazygit fzf zoxide xclip

# Gnome setup.
if command -v gsettings &>/dev/null; then
    echo "Installing gnome settings..."
    gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_shifted_capslock']"
fi

echo "Installig flatpak packages..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.mattjakeman.ExtensionManager
flatpak install flathub org.mozilla.Thunderbird
# flatpak install flathub eu.betterbird.Betterbird
# flatpak install flathub org.gnome.Extensions
flatpak install flathub org.mozilla.firefox
flatpak install flathub org.videolan.VLC
flatpak install flathub org.telegram.desktop
flatpak install flathub com.visualstudio.code
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub com.transmissionbt.Transmission
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community
