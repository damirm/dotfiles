#!/usr/bin/env bash

echo "Installing cursor theme..."
sudo dnf copr enable -y muhalantabli/copr-repo
sudo dnf install -y bibata-cursor-theme

echo "Installing gnome shell extensions"
sudo dnf install -y \
  gnome-shell-extension-dash-to-dock

pipx install gnome-extensions-cli

gext install space-bar@luchrioh
gext install appindicatorsupport@rgcjonas.gmail.com
gext install Vitals@CoreCoding.com
# gext install just-perfection-desktop@just-perfection
gext install undecorate@sun.wxg@gmail.com
gext install KeepAwake@jepfa.de

echo "Installing gnome settings..."
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'grp:alt_space_toggle']"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'en'), ('xkb', 'ru')]"

gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5

gsettings set org.gnome.shell.keybindings switch-to-application-1 "['disabled']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['disabled']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['disabled']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['disabled']"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['disabled']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Shift><Super>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Shift><Super>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Shift><Super>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Shift><Super>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Shift><Super>5']"
gsettings reset org.gnome.shell.keybindings toggle-application-view
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>q']"
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up']"

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter auto-maximize false

gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Control>space'

# Setup dash-to-dock
dash_to_dock_apps=(
  "Alacritty.desktop"
  "org.mozilla.firefox.desktop"
  "org.telegram.desktop.desktop"
  "eu.betterbird.Betterbird.desktop"
  # "org.mozilla.Thunderbird.desktop"
  "org.gnome.Nautilus.desktop"
  "org.gnome.Settings.desktop"
  "com.jetbrains.IntelliJ-IDEA-Community.desktop"
  "md.obsidian.Obsidian.desktop"
  "1password.desktop"
  "com.transmissionbt.Transmission.desktop"
  "com.visualstudio.code.desktop"
  "org.gnome.Boxes.desktop"
  "org.gnome.Software.desktop"
  "org.gnome.SystemMonitor.desktop"
)

favorites_list=$(printf "'%s'," "${dash_to_dock_apps[@]}")
favorites_list="[${favorites_list%,}]"

# Set the favorite apps
gsettings set org.gnome.shell favorite-apps "$favorites_list"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'

mkdir -p ~/.config/autostart/
ln -f -s $(pwd)/fedora/home/.config/autostart/ulauncher.desktop "$HOME/.config/autostart/ulauncher.desktop"
