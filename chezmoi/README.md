# Dotfiles

My dotfiles managed with [chezmoi](https://www.chezmoi.io/). Supports multiple operating systems (macOS, Fedora, CachyOS) and desktop environments (GNOME, KDE).

## Features

- **Cross-platform**: Works on macOS, Fedora, CachyOS, and other Linux distributions
- **Desktop Environment support**: GNOME and KDE configurations
- **Template-based**: Different configurations based on hostname (e.g., font size 14 vs 16)
- **Automated setup**: Run-once scripts for installing packages and configuring systems
- **External dependencies**: Automatic download of oh-my-zsh, TPM, and plugins

## Quick Start

### Install chezmoi

```bash
# macOS
brew install chezmoi

# Fedora
sudo dnf install chezmoi

# Arch/CachyOS
sudo pacman -S chezmoi

# Or use the official installer
/bin/bash -c "$(curl -fsLS get.chezmoi.io)"
```

### Apply dotfiles

```bash
# Initialize and apply (first time)
chezmoi init --apply https://github.com/damirm/dotfiles.git

# Or if already initialized
chezmoi apply
```

### Initialize on a new machine

```bash
# One-liner for new machines
/bin/bash -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/damirm/dotfiles.git
```

## Structure

```
dotfiles/
├── .chezmoi.toml.tmpl      # Main configuration template
├── .chezmoiignore          # Files to ignore
├── .chezmoiremove          # Files to remove on apply
├── .chezmoiexternal.toml   # External dependencies (oh-my-zsh, TPM, etc.)
├── dotfiles/               # Dotfiles to be symlinked/copied
│   ├── .config/            # XDG config files
│   ├── .ssh/               # SSH configuration (not keys!)
│   ├── .shell/             # Shell configuration files
│   ├── bin/                # Executable scripts
│   └── ...
└── scripts/                # Run-once setup scripts
    ├── run_once_install_*.sh
    └── run_once_setup_*.sh
```

## Scripts

### Installation scripts (run_once)

| Script | Description |
|--------|-------------|
| `run_once_install_oh-my-zsh.sh` | Install Oh My Zsh and plugins |
| `run_once_install_mise_tools.sh` | Install tools via mise |
| `run_once_install_vscode_extensions.sh` | Install VSCode extensions |
| `run_once_install_fonts.sh` | Install fonts |
| `run_once_create_ssh_keys.sh` | Create SSH keys |

### Setup scripts (run_once)

| Script | Description |
|--------|-------------|
| `run_once_setup_macos.sh` | macOS defaults and settings |
| `run_once_setup_gnome.sh` | GNOME extensions and settings |
| `run_once_setup_dnf.sh` | DNF repositories and packages |
| `run_once_setup_flatpak.sh` | Flatpak applications |
| `run_once_setup_homebrew.sh` | Homebrew packages |
| `run_once_setup_yubikey.sh` | YubiKey U2F setup |

## Running scripts manually

```bash
# List all scripts
chezmoi script

# Run a specific script
chezmoi script run_once_install_oh-my-zsh.sh

# Run all scripts
chezmoi apply --init
```

## Configuration

### Hostname-based configuration

The `.chezmoi.toml.tmpl` detects your hostname and applies specific settings:

- **macbook**: Font size 14
- **Other hosts**: Font size 16

To add hostname-specific settings, edit `.chezmoi.toml.tmpl`:

```toml
{{- if eq $hostname "your-hostname" }}
font_size = 18
{{- end }}
```

### OS-specific configuration

Templates can use these variables:

```
{{ .data.is_macos }}    # true on macOS
{{ .data.is_linux }}    # true on Linux
{{ .data.is_fedora }}   # true on Fedora
{{ .data.is_gnome }}    # true on GNOME
{{ .data.is_kde }}      # true on KDE
```

## Private configurations

For private configurations (not committed to repo):

1. Create `~/.zshrc.private` for private zsh settings
2. Use `chezmoi edit --encrypt` for sensitive files
3. Add private files to `.chezmoiignore`

## Migration from stow

If you're migrating from the old stow-based setup:

```bash
# Remove old stow symlinks
stow -D alacritty tmux nvim zsh brew starship kitty sesh mise terraform git scripts
stow -D --no-folding ssh vscode

# Apply chezmoi
chezmoi apply
```

## Troubleshooting

### Check what will change

```bash
chezmoi diff
```

### Force apply

```bash
chezmoi apply --force
```

### Check template output

```bash
chezmoi execute-template '{{ .data.is_macos }}'
chezmoi execute-template '{{ .data.font_size }}'
```

### Verify external dependencies

```bash
chezmoi update
```

## Supported Tools

| Category | Tools |
|----------|-------|
| Shell | zsh, oh-my-zsh, starship, zoxide |
| Terminal | alacritty, kitty |
| Editor | nvim, vscode |
| Multiplexer | tmux (with TPM) |
| Version Manager | mise |
| Dev Tools | git, terraform, kubectl |
| Session Manager | sesh |

## License

MIT
