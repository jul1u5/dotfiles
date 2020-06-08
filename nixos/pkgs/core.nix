{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    exa
    fd
    file
    fzf
    git
    gnupg
    htop
    jq
    lf
    neofetch
    ripgrep
    stow
    tldr
    tree
    unrar
    unzip
    wget
    zip
  ];
}
