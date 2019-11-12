{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    plata-theme
    paper-icon-theme
    papirus-icon-theme
  ];
}
