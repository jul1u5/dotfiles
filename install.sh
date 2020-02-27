#!/usr/bin/env bash

stow fish git

# Install Fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -c "fisher"
