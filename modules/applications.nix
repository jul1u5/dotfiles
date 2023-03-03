{ pkgs, ... }:

{
  environment.sessionVariables = {
    BROWSER = "firefox";
    # Maybe required for electron apps like discord?
    # DEFAULT_BROWSER = "firefox";
    # MOZ_DBUS_REMOTE = "1";
  };

  user.packages = with pkgs; [
    # Browsers
    (firefox-wayland.override {
      cfg = {
        enableGnomeExtensions = true;
        enableTridactylNative = true;
      };
    })
    chromium
    google-chrome
    lynx
    vivaldi

    # File Browsers
    gnome3.nautilus
    pcmanfm

    # Terminals
    alacritty
    foot
    kitty

    # Development
    # vimHugeX
    android-studio
    postman

    # Graphics
    blender
    gimp
    gthumb
    unstable.inkscape
    krita

    # Office
    libreoffice
    unstable.obsidian
    zotero

    # Media
    imv
    mpv
    spot

    # Instant Messengers
    discord
    unstable.webcord
    element-desktop
    unstable.signal-desktop
    slack
    teams
    zoom-us

    # Misc
    authy
    bottles
    ghidra-bin
    gparted
    psensor
    remmina
    transmission-gtk
    variety
    zathura
  ];
}
