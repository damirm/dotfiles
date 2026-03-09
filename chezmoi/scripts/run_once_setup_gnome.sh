#!/usr/bin/env bash
# run_once_setup_gnome.sh
# GNOME desktop environment setup

set -e

echo "==> Setting up GNOME..."

# Check if running on GNOME
if [[ $(env | grep XDG_CURRENT_DESKTOP | grep -i gnome) == "" ]]; then
  echo "Not running on GNOME, skipping..."
  exit 0
fi

# Check if running on Linux
if [[ $(uname -s) != 'Linux' ]]; then
  echo "Not running on Linux, skipping..."
  exit 0
fi

# Install cursor theme
echo "Installing cursor theme..."
if command -v dnf &> /dev/null; then
  if ! rpm -q bibata-cursor-theme &> /dev/null; then
    sudo dnf copr enable -y muhalantabli/copr-repo
    sudo dnf install -y bibata-cursor-theme
  else
    echo "Bibata cursor theme already installed, skipping..."
  fi
fi

# Install GNOME extensions
echo "Installing GNOME extensions..."
if command -v dnf &> /dev/null; then
  sudo dnf install -y \
    gnome-shell-extension-dash-to-dock \
    gnome-shell-extension-appindicator \
    gnome-extensions-app || true
fi

# Install gext CLI
if ! command -v gext &> /dev/null; then
  echo "Installing gext CLI..."
  if command -v pipx &> /dev/null; then
    pipx install gnome-extensions-cli
  fi
fi

# Install extensions via gext
if command -v gext &> /dev/null; then
  EXTENSIONS=(
    "space-bar@luchrioh"
    "appindicatorsupport@rgcjonas.gmail.com"
    "Vitals@CoreCoding.com"
    "undecorate@sun.wxg@gmail.com"
    "KeepAwake@jepfa.de"
    "gsconnect@andyholmes.github.io"
  )

  for ext in "${EXTENSIONS[@]}"; do
    echo "Installing extension: $ext"
    gext install "$ext" || echo "Failed to install $ext, continuing..."
  done
fi

# GNOME settings
echo "Applying GNOME settings..."

# Input sources
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'grp:alt_space_toggle']"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'en'), ('xkb', 'ru')]"

# Workspaces
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5

# Keybindings
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

# Interface settings
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface enable-animations true
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter auto-maximize false

# Dash-to-dock
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'

# Custom keybinding for ulauncher
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Control>space'

# Setup dash-to-dock favorites
dash_to_dock_apps=(
  "Alacritty.desktop"
  "org.mozilla.firefox.desktop"
  "org.telegram.desktop.desktop"
  "eu.betterbird.Betterbird.desktop"
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
gsettings set org.gnome.shell favorite-apps "$favorites_list"

# Setup autostart for ulauncher
echo "Setting up ulauncher autostart..."
mkdir -p ~/.config/autostart/
if [ -f "$(pwd)/dotfiles/.config/autostart/ulauncher.desktop" ]; then
  ln -f -s "$(pwd)/dotfiles/.config/autostart/ulauncher.desktop" "$HOME/.config/autostart/ulauncher.desktop"
fi

echo "==> GNOME setup complete!"
echo "Note: Some changes require logout/login to take effect."
