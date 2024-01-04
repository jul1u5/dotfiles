{pkgs, ...}: {
  environment.sessionVariables = {
    BROWSER = "firefox";
    # Maybe required for electron apps like discord?
    # DEFAULT_BROWSER = "firefox";
    # MOZ_DBUS_REMOTE = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home._ = {
    programs.firefox = {
      enable = true;
      enableGnomeExtensions = true;
      package = pkgs.firefox.override {
        cfg = {
          enableTridactylNative = true;
          enableGnomeExtensions = true;
        };
      };
    };
  };

  user.packages = with pkgs; [
    # Browsers
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
    # postman

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

    # Instant Messengers
    discord
    unstable.webcord
    element-desktop
    unstable.signal-desktop
    slack
    zoom-us
    unstable.telegram-desktop

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
