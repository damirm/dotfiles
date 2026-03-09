#!/usr/bin/env bash
# run_once_create_ssh_keys.sh
# Create SSH keys if they don't exist

set -e

EMAIL="iam@damir.space"
ALGORITHM="ed25519"

KEYS=(
  "$HOME/.ssh/raspberry_id_$ALGORITHM"
  "$HOME/.ssh/homelab_id_$ALGORITHM"
  "$HOME/.ssh/github_id_$ALGORITHM"
  "$HOME/.ssh/cudy_id_$ALGORITHM"
)

echo "==> Setting up SSH keys..."

for key in ${KEYS[*]}; do
  if [ ! -f "$key" ]; then
    echo "Creating $key..."
    ssh-keygen -t "$ALGORITHM" -C "$EMAIL" -f "$key" -N ""
  else
    echo "Key $key already exists, skipping..."
  fi
done

echo "==> SSH keys setup complete!"
