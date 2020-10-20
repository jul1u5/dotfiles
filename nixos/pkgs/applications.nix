{ pkgs, ... }:

{
  programs = { wireshark.enable = true; };

  environment.systemPackages = with pkgs; [
    alacritty
    blender
    discord
    # (import (fetchTarball {
    #   url = "https://github.com/NixOS/nixpkgs/archive/master.tar.gz";
    # }) { config = { allowUnfree = true; }; }).discord
    dmenu
    feh
    flameshot
    gimp
    gnome3.nautilus
    google-chrome
    gparted
    gthumb
    inkscape
    kitty
    krita
    libreoffice
    lutris
    lxappearance
    mpv
    octave
    pavucontrol
    pick-colour-picker
    postman
    pulseeffects
    remmina
    rofi
    scrot
    signal-desktop
    spotify
    teams
    transmission-gtk
    virt-manager
    wireshark
    zoom-us
    zotero
  ];
}
