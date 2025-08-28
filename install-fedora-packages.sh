#!/usr/bin/env bash

function gnome_set {
    local schema=$1
    local key=$2
    local value=$3
    gsettings set $schema $key $value
}

function install_nerd_font {
    local remote_file=$1
    local zip_file=$(basename $remote_file)
    local tmp_dir="/tmp"
    local dst_dir=$HOME/.local/share/fonts

    echo "Installing font from $remote_file..."
    wget -P $tmp_dir $remote_file
    mkdir -p $dst_dir
    unzip -o $tmp_dir/$zip_file -d $dst_dir
    sudo fc-cache -v
    rm $tmp_dir/$zip_file
}

function install_gnome_extension {
    local extension_id=$1
    local remote_file=$2
    local zip_file=$(basename $remote_file)
    local tmp_dir="/tmp"
    local dst_dir="$HOME/.local/share/gnome-shell/extensions/$extension_id"

    echo "Installing gnome extension $extension_url from $remote_file..."

    wget -P $tmp_dir $remote_file
    mkdir -p $dst_dir
    unzip -o $tmp_dir/$zip_file -d $dst_dir
    gnome-extensions enable $extension_id
    rm $tmp_dir/$zip_file
}

echo "Setup dnf..."
sudo dnf config-manager setopt fastestmirror=true
sudo dnf config-manager setopt max_parallel_downloads=10

echo "Enabling rpm fusion and terra..."
# sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
# sudo rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

# echo "Updating firmware..."
# sudo fwupdmgr refresh --force
# sudo fwupdmgr get-devices
# sudo fwupdmgr get-updates
# sudo fwupdmgr update -y

echo "Enable dnf repositories..."
sudo dnf copr enable -y jdxcode/mise
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y dejan/lazygit

sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
sudo dnf check-update

echo "Installing packages..."
sudo dnf update -y
sudo dnf update -y @core
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
    xclip \
    fastfetch \
    gnome-tweaks \
    alacritty \
    jetbrains-mono-nl-fonts \
    1password \
    htop \
    btop

echo "Installing fonts"
install_nerd_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip

# Gnome setup.
if command -v gsettings &>/dev/null; then
    echo "Installing gnome shell extensions"
    sudo dnf install -y \
        gnome-shell-extension-dash-to-dock

    install_gnome_extension "appindicatorsupport@rgcjonas.gmail.com" "https://github.com/ubuntu/gnome-shell-extension-appindicator/releases/download/v60/appindicatorsupport@rgcjonas.gmail.com.zip"
    install_gnome_extension "Vitals@CoreCoding.com" "https://github.com/corecoding/Vitals/releases/download/v72.0.0/vitals.zip"

    echo "Installing gnome settings..."
    gnome_set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_shifted_capslock']"
    gnome_set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gnome_set org.gnome.desktop.interface show-battery-percentage true
fi

echo "Installing flatpak packages..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub \
    com.mattjakeman.ExtensionManager \
    org.mozilla.Thunderbird \
    org.videolan.VLC \
    org.telegram.desktop \
    com.visualstudio.code \
    md.obsidian.Obsidian \
    com.transmissionbt.Transmission \
    com.jetbrains.IntelliJ-IDEA-Community \
    com.visualstudio.code

# eu.betterbird.Betterbird
# org.gnome.Extensions
# org.mozilla.firefox

# Misc settings.
sudo systemctl disable NetworkManager-wait-online.service

# TODO: yubikey setup
# TODO: gnome-tweaks (ctrl-space for search, super+N for workspace switching)
