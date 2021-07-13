{ lib, config, pkgs, ... }:

{
  programs.sway = {
    enable = true;

    wrapperFeatures.gtk = true;

    extraSessionCommands = ''
      systemctl --user import-environment

      export MOZ_ENABLE_WAYLAND=1
      export MOZ_USE_XINPUT2=1

      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

      # Fix for some Java AWT applications (e.g. Android Studio)
      export _JAVA_AWT_WM_NONREPARENTING=1

      XDG_DESKTOP_DIR="$HOME"
      XDG_DOWNLOAD_DIR="$HOME/Downloads"
      XDG_TEMPLATES_DIR="$HOME/Templates"
      XDG_PUBLICSHARE_DIR="$HOME/Public"
      XDG_DOCUMENTS_DIR="$HOME/Documents"
      XDG_MUSIC_DIR="$HOME/Music"
      XDG_PICTURES_DIR="$HOME/Pictures"
      XDG_VIDEOS_DIR="$HOME/Videos"
    '';

    extraPackages = with pkgs; [
      swaylock-effects
      swayidle

      xwayland
      kanshi

      waybar
      mako
      wob

      qt5.qtwayland

      gnome3.networkmanagerapplet
      libappindicator

      blueberry
      udiskie
      wdisplays

      wofi
      rofimoji

      wl-clipboard

      sway-contrib.grimshot

      nwg-launchers
      wf-recorder

      my.rot8
    ];
  };

  # Link libexec path so that polkit can be started by sway
  environment.pathsToLink = [ "/libexec" ];

  xdg.portal.enable = true;

  systemd.user.services.xdg-desktop-portal.environment = {
    XDG_DESKTOP_PORTAL_DIR = config.environment.variables.XDG_DESKTOP_PORTAL_DIR;
  };

  services = {
    pipewire.enable = true;

    redshift = {
      enable = true;
      package = pkgs.redshift-wlr;
      executable = "/bin/redshift-gtk";
    };
  };

  user.packages = with pkgs; [
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas

    polkit_gnome
  ];

  user.extraGroups = [ "sway" ];
}
