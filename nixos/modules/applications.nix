{ pkgs, ... }:

{
  environment.variables = {
    BROWSER = "firefox";
    MOZ_DBUS_REMOTE = "1";
  };

  user.packages = with pkgs; [
    # Browsers
    lynx
    chromium
    (firefox-wayland.override {
      cfg.enableTridactylNative = true;
    })

    # Terminals
    alacritty
    foot
    kitty

    # Development
    vimHugeX
    androidStudioPackages.canary
    octave
    postman

    # Graphics
    gimp
    gthumb
    imv
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
