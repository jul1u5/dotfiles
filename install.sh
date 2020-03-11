#!/usr/bin/env bash

stow fish git

# Install starship
curl -fsSL https://starship.rs/install.sh | bash -s -- --yes

# Install Fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -c "fisher"
