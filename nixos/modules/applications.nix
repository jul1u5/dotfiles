{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Browsers
    lynx
    chromium
    (unstable.firefox-wayland.override {
      cfg.enableTridactylNative = true;
    })

    # Terminals
    kitty
    alacritty

    # Development
    vimHugeX
    androidStudioPackages.canary
    octave
    postman

    # Graphics
    feh
    gimp
    gthumb
    inkscape
    krita

    # Office
    libreoffice
    zotero

    # Video
    mpv

    # Instant Messengers
    unstable.discord
    element-desktop
    signal-desktop
    slack
    teams
    zoom-us

    # Misc
    blender
    gnome3.nautilus
    gparted
    psensor
    remmina
    spotify
    transmission-gtk
    zathura
  ];
}
