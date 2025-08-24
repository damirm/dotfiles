#!/usr/bin/env bash

if command -v brew >/dev/null 2>&1; then
    echo "Installing brew packages..."
    BREWFILE="$HOME/.config/homebrew/Brewfile"
    brew bundle check -v --file $BREWFILE || brew bundle install --file $BREWFILE
fi

echo "Creating symlinks..."
stow -t $HOME alacritty tmux nvim zsh brew starship kitty

# NOTE: Moved to tmux.conf itself.
# TMUX_TPM_DIR="$HOME/.tmux/plugins/tpm"
# if test ! -d $TMUX_TPM_DIR; then
#     echo "Installing tmux-tpm..."
#     git clone https://github.com/tmux-plugins/tpm $TMUX_TPM_DIR
#     $TMUX_TPM_DIR/bin/install_plugins
# fi
