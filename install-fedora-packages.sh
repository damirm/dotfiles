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

function install_gnome_extension {
    local extension_id=$1
    local remote_file=$2
    local zip_file=$(basename $remote_file)
    local tmp_dir="/tmp"
    local dst_dir="$HOME/.local/share/gnome-shell/extensions/$extension_id"

    if test -d $dst_dir; then
        echo "Gnome extension $extension_id is already installed, skipping..."
        return 0
    fi

    echo "Installing gnome extension $extension_url from $remote_file..."

    wget -P $tmp_dir $remote_file
    mkdir -p $dst_dir
    # TODO: Move to temporary dir first, then extract uuid, and then move to extensions dir.
    unzip -o $tmp_dir/$zip_file -d $dst_dir
    gnome-extensions enable $extension_id
    rm $tmp_dir/$zip_file
}

echo "Setup dnf..."
sudo dnf config-manager setopt fastestmirror=true
sudo dnf config-manager setopt max_parallel_downloads=10

if ! dnf repolist | grep -q rpmfusion; then
    echo "Enabling rpm fusion and terra..."
    sudo dnf install -y \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
    sudo dnf update -y
    sudo dnf update -y @core
fi

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

install_nerd_font "JetBrainsMono" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"

# Gnome setup.
if command -v gsettings &>/dev/null; then
    echo "Installing gnome shell extensions"
    sudo dnf install -y \
        gnome-shell-extension-dash-to-dock

    install_gnome_extension "appindicatorsupport@rgcjonas.gmail.com" "https://github.com/ubuntu/gnome-shell-extension-appindicator/releases/download/v60/appindicatorsupport@rgcjonas.gmail.com.zip"
    install_gnome_extension "Vitals@CoreCoding.com" "https://github.com/corecoding/Vitals/releases/download/v72.0.0/vitals.zip"
    # install_gnome_extension "space-bar@luchrioh" "https://github.com/christopher-l/space-bar/releases/download/v33/space-bar@luchrioh.shell-extension.zip"

    echo "Installing gnome settings..."
    gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'grp:alt_space_toggle']"
    gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'en'), ('xkb', 'ru')]"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface show-battery-percentage true
    gsettings set org.gnome.mutter dynamic-workspaces false
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 5

    gsettings reset org.gnome.desktop.wm.keybindings switch-to-application-1
    gsettings reset org.gnome.desktop.wm.keybindings switch-to-application-2
    gsettings reset org.gnome.desktop.wm.keybindings switch-to-application-3
    gsettings reset org.gnome.desktop.wm.keybindings switch-to-application-4
    gsettings reset org.gnome.desktop.wm.keybindings switch-to-application-5
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
    gsettings set org.gnome.shell.keybindings toggle-application-view "['<Control>Space']"
    gsettings set org.gnome.desktop.interface enable-animations false
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

# Misc settings.
sudo systemctl disable NetworkManager-wait-online.service

# TODO: yubikey setup
# TODO: gnome settings (ctrl-space for search, super+N for workspace switching)
# TODO: firefox plugins
