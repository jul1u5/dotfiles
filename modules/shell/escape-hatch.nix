{ pkgs, ... }:

{
  programs.nix-ld.enable = true;

  user.packages = with pkgs; [
    nix-alien
    nix-index-update
  ];
}
