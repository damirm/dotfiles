#!/usr/bin/env bash

cat << EOF | xargs -L 1 code --install-extension
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
EOF

# dart-code.dart-code
# dart-code.flutter
# mathiasfrohlich.kotlin
# ms-vscode.cmake-tools
# ms-vscode.makefile-tools
# redhat.java
# tamasfe.even-better-toml
# twxs.cmake
# vscjava.migrate-java-to-azure
# vscjava.vscode-gradle
# vscjava.vscode-java-debug
# vscjava.vscode-java-dependency
# vscjava.vscode-java-pack
# vscjava.vscode-java-test
# vscjava.vscode-java-upgrade
# vscjava.vscode-maven

[[ $OSTYPE == 'darwin'* ]] && ln -f -s "$HOME/.config/Code/User/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
