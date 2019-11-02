{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file
    git
    gnupg
    htop
    tree
    unzip
    wget
    zip
  ];
}