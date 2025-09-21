#!/usr/bin/env bash

EMAIL="iam@damir.space"
ALGORITHM="ed25519"

KEYS=(
  "$HOME/.ssh/raspberry_id_$ALGORITHM"
  "$HOME/.ssh/homelab_id_$ALGORITHM"
  "$HOME/.ssh/github_id_$ALGORITHM"
)

for key in ${KEYS[*]}; do
  if [ ! -f "$key" ]; then
    echo "Creating $key..."
    ssh-keygen -t "$ALGORITHM" -C "$EMAIL" -f "$key" -N ""
  fi
done
