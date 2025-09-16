#!/usr/bin/env bash

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

# if ! dnf repolist | grep -q zsh-autosuggestions; then
#     sudo dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/shells:zsh-users:zsh-autosuggestions/Fedora_Rawhide/shells:zsh-users:zsh-autosuggestions.repo
# fi

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
  pipx \
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
  gum \
  fd-find \
  bat \
  tldr \
  ulauncher \
  pam-u2f \
  pamu2fcfg \
  tor \
  torsocks \
  telnet \
  zsh-autosuggestions \
  ansible \
  ncdu \
  @virtualization

sudo usermod -a -G libvirt $(whoami)

# NOTE: Tools like uv, pipx, ansible, ruff and lot more
# can be installed via mise: https://mise.jdx.dev/registry.html#tools
# For now I decided to go with dnf, but there is a pros about install it via mise: crosspatform package manager.
# If it will be installed via mise - I can remove that packages from Brewfile and install-fedora-packages.sh.

# TODO: Install eza, x-cmd
