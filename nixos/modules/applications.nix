{ pkgs, modulesPath, ... }:

{
  programs = { wireshark.enable = true; };

  environment.systemPackages = with pkgs; [
    androidStudioPackages.canary
    alacritty
    blender
    unstable.discord
    dmenu
    feh
    (firefox-wayland.override {
      cfg.enableTridactylNative = true;
    })
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
    unstable.lutris
    legendary-gl
    wineWowPackages.stable
    lxappearance
    mpv
    octave
    pavucontrol
    postman
    pulseeffects-pw
    remmina
    rofi
    scrot
    signal-desktop
    slack
    spotify
    teams
    transmission-gtk
    virt-manager
    wireshark
    zathura
    zoom-us
    zotero
  ];
}
