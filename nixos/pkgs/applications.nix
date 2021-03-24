{ pkgs, modulesPath, ... }:

{
  nixpkgs.overlays = [
    (import ../overlays/android-studio.nix { inherit modulesPath; })
  ];

  programs = { wireshark.enable = true; };

  environment.systemPackages = with pkgs; [
    androidStudioPackages.canary
    alacritty
    blender
    discord
    dmenu
    feh
    firefox-wayland
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
