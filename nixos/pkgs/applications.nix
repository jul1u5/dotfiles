{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    blender
    discord
    emacs
    gimp
    google-chrome
    gparted
    inkscape
    kitty
    krita
    lutris
    lxappearance
    mpv
    gnome3.nautilus
    pavucontrol
    psensor
    radare2
    spotify
    steam
    transmission-gtk
    wireshark-qt
  ];
}
