{ pkgs, ... }:

{
  environment.sessionVariables = {
    BROWSER = "firefox";
    # Maybe required for electron apps like discord?
    # DEFAULT_BROWSER = "firefox";
    MOZ_DBUS_REMOTE = "1";
  };

  services = {
    flatpak.enable = true;
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
    obsidian
    zotero

    # Media
    imv
    mpv
    spotify
    spot

    # Instant Messengers
    (discord.override { nss = nss_latest; })
    element-desktop
    signal-desktop
    slack
    teams
    zoom-us

    # Misc
    (assert authy.version == "2.1.0"; unstable.authy) # Stable authy uses electron which is EOL
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
