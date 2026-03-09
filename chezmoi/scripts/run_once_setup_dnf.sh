#!/usr/bin/env bash
# run_once_setup_dnf.sh
# DNF package manager setup for Fedora

set -e

echo "==> Setting up DNF..."

# Check if running on Fedora
if ! command -v dnf &> /dev/null; then
  echo "DNF not found (not Fedora?), skipping..."
  exit 0
fi

# Configure DNF
echo "Configuring DNF..."
sudo dnf config-manager setopt fastestmirror=true
sudo dnf config-manager setopt max_parallel_downloads=20

# Link Yandex mirror repo
if [ -f "$(pwd)/dotfiles/etc/yum.repos.d/yandex-mirror.repo" ]; then
  echo "Linking Yandex mirror repository..."
  sudo mkdir -p /etc/yum.repos.d/
  sudo ln -f -s "$(pwd)/dotfiles/etc/yum.repos.d/yandex-mirror.repo" /etc/yum.repos.d/yandex-mirror.repo
fi

# Enable DNF repositories
echo "Enabling DNF repositories..."

# Enable COPR repositories
sudo dnf copr enable -y jdxcode/mise || true
sudo dnf copr enable -y atim/starship || true
sudo dnf copr enable -y dejan/lazygit || true

# Enable 1Password repository
if ! dnf repolist | grep -q 1password; then
  echo "Enabling 1Password repository..."
  sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
  sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
  sudo dnf check-update || true
fi

# Enable RPM Fusion repository
if ! dnf repolist | grep -q rpmfusion; then
  echo "Enabling RPM Fusion..."
  sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
fi

# Enable Terra repository
if ! dnf repolist | grep -q terra; then
  echo "Enabling Terra repository..."
  sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release || true
fi

# Update system
echo "Updating system packages..."
sudo dnf update -y --skip-unavailable --exclude openh264

# Add user to libvirt group
echo "Adding user to libvirt group..."
sudo usermod -a -G libvirt $(whoami)

echo "==> DNF setup complete!"
echo "Note: You may need to reboot for group changes to take effect."
