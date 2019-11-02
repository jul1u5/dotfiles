{ pkgs, ... }:

{
  programs.sway.enable = true;

  services.xserver.displayManager = {
    extraSessionFilePackages = [ pkgs.sway ];
  };
}