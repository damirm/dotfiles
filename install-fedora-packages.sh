#!/usr/bin/env bash

function install_nerd_font {
    local font_name="$1"
    local remote_file="$2"
    local zip_file=$(basename $remote_file)
    local tmp_dir="/tmp"
    local dst_dir=$HOME/.local/share/fonts

    if fc-list | grep -q "$font_name"; then
        echo "Font $font_name is already exists, skipping..."
        return 0
    fi

    echo "Installing font from $remote_file..."
    wget -P $tmp_dir $remote_file
    mkdir -p $dst_dir
    unzip -o $tmp_dir/$zip_file -d $dst_dir
    sudo fc-cache -v
    rm $tmp_dir/$zip_file
}

echo "Setup dnf..."
sudo dnf config-manager setopt fastestmirror=true
sudo dnf config-manager setopt max_parallel_downloads=20

echo "Enable dnf repositories..."
sudo dnf copr enable -y jdxcode/mise
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y dejan/lazygit

if ! dnf repolist | grep -q 1password; then
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
    sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
    sudo dnf check-update
fi

if ! dnf repolist | grep -q rpmfusion; then
    echo "Enabling rpm fusion and terra..."
    sudo dnf install -y \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

    # sudo cp -f fedora/etc/yum.repos.d/yandex-mirror.repo /etc/yum.repos.d/yandex-mirror.repo
    sudo ln -s $(pwd)/fedora/etc/yum.repos.d/yandex-mirror.repo /etc/yum.repos.d/yandex-mirror.repo
fi

sudo dnf update -y --skip-unavailable

# echo "Updating firmware..."
# sudo fwupdmgr refresh --force
# sudo fwupdmgr get-devices
# sudo fwupdmgr get-updates
# sudo fwupdmgr update -y

echo "Installing packages..."
sudo dnf install -y \
    stow \
    zsh \
    nvim \
    mise \
    ripgrep \
    tmux \
    uv \
    ruff \
    starship \
    lazygit \
    fzf \
    zoxide \
    fastfetch \
    gnome-tweaks \
    alacritty \
    jetbrains-mono-nl-fonts \
    1password \
    1password-cli \
    htop \
    btop \
    pipx \
    gum \
    fd-find \
    bat \
    eza \
    tldr \
    ulauncher \
    pam-u2f \
    pamu2fcfg \
    tor \
    torsocks \
    telnet

install_nerd_font "JetBrainsMono" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"

# Gnome setup.
if command -v gsettings &>/dev/null; then
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
    gext install just-perfection-desktop@just-perfection
    gext install undecorate@sun.wxg@gmail.com

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
fi

# Setup yubikey
if lsusb | grep -i yubikey; then
    if [ ! -f ~/.config/Yubico/u2f_keys ]; then
        mkdir -p ~/.config/Yubico
        echo "Touch yubikey: "
        pamu2fcfg >~/.config/Yubico/u2f_keys
        sudo authselect select local
        sudo authselect enable-feature with-pam-u2f
        sudo authselect apply-changes
    fi
fi

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
    com.visualstudio.code

# org.mozilla.Thunderbird

# Misc settings.
sudo systemctl disable NetworkManager-wait-online.service

# Install byedpi
if ! command -v ciadpi &>/dev/null; then
    tmp_dir=$(mktemp -d)
    remote_zip="https://github.com/hufrea/byedpi/releases/download/v0.17.2/byedpi-17.2-x86_64.tar.gz"
    file_name=$(basename "$remote_zip")
    wget -P "$tmp_dir" "$remote_zip"
    tar zxvf "$tmp_dir/$file_name" -C "$tmp_dir"
    mkdir -p "$HOME/.local/bin"
    mv "$tmp_dir/ciadpi-x86_64" "$HOME/.local/bin/ciadpi"
    user_systemd_dir="$HOME/.config/systemd/user"
    mkdir -p "$user_systemd_dir"
    ln -s $(pwd)/fedora/home/.config/systemd/user/byedpi.service "$user_systemd_dir/byedpi.service"
    systemctl --user daemon-reload
    systemctl --user enable byedpi.service
    systemctl --user start byedpi.service
fi

mkdir -p ~/.config/autostart/
ln -f -s $(pwd)/fedora/home/.config/autostart/ulauncher.desktop "$HOME/.config/autostart/ulauncher.desktop"

# TODO: Firefox plugins
# TODO: Ulauncher settings
