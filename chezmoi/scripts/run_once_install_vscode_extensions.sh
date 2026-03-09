#!/usr/bin/env bash
# run_once_install_vscode_extensions.sh
# Install VSCode extensions

set -e

echo "==> Installing VSCode extensions..."

# Check if code command is available
if ! command -v code &> /dev/null; then
  echo "VSCode 'code' command not found. Skipping extension installation."
  echo "Install VSCode first or use Flatpak version."
  exit 0
fi

# Install extensions
EXTENSIONS=(
  4ops.terraform
  a-h.templ
  aaron-bond.better-comments
  adpyke.codesnap
  akamud.vscode-theme-onedark
  akamud.vscode-theme-onelight
  anan.jetbrains-darcula-theme
  arcticicestudio.nord-visual-studio-code
  bierner.markdown-mermaid
  biomejs.biome
  chadalen.vscode-jetbrains-icon-theme
  charliermarsh.ruff
  eamodio.gitlens
  editorconfig.editorconfig
  esbenp.prettier-vscode
  firsttris.vscode-jest-runner
  github.copilot
  github.copilot-chat
  github.github-vscode-theme
  golang.go
  google.geminicodeassist
  hashicorp.terraform
  informal.quint-vscode
  kosz78.nim
  ms-python.autopep8
  ms-python.debugpy
  ms-python.python
  ms-python.vscode-pylance
  ms-python.vscode-python-envs
  ms-vscode.cpptools
  ms-vscode.cpptools-extension-pack
  ms-vscode.cpptools-themes
  redhat.vscode-yaml
  rokoroku.vscode-theme-darcula
  rooveterinaryinc.roo-cline
  rust-lang.rust-analyzer
  saoudrizwan.claude-dev
  shd101wyy.markdown-preview-enhanced
  smulyono.reveal
  tonybaloney.vscode-pets
  visualstudioexptteam.intellicode-api-usage-examples
  visualstudioexptteam.vscodeintellicode
  vlanguage.vscode-vlang
  vscodevim.vim
  yzhang.markdown-all-in-one
  zhuangtongfa.material-theme
  ziglang.vscode-zig
  zxh404.vscode-proto3
)

for extension in "${EXTENSIONS[@]}"; do
  echo "Installing $extension..."
  code --install-extension "$extension" || echo "Failed to install $extension, continuing..."
done

# Create symlink for VSCode settings on macOS
if [[ $(uname -s) == 'Darwin' ]]; then
  echo "Creating VSCode settings symlink for macOS..."
  mkdir -p "$HOME/Library/Application Support/Code/User"
  ln -f -s "$HOME/.config/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json" 2> /dev/null || true
fi

echo "==> VSCode extensions installation complete!"
