{ pkgs, unstable, ... }:

{
  programs = { wireshark.enable = true; };

  environment.systemPackages = with pkgs; [
    unstable.androidStudioPackages.canary
    alacritty
    blender
    unstable.discord
    dmenu
    feh
    firefox-bin
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
    # lutris
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
    unstable.spotify
    teams
    transmission-gtk
    virt-manager
    wireshark
    zoom-us
    zotero
  ];
}
