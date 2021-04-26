{ lib, config, pkgs, ... }:

{
  programs.sway = {
    enable = true;

    wrapperFeatures.gtk = true;

    extraSessionCommands = ''
      systemctl --user import-environment

      export XDG_CURRENT_DESKTOP=sway

      export MOZ_ENABLE_WAYLAND=1
      export MOZ_USE_XINPUT2=1

      # needs qt5.qtwayland in systemPackages
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
      swaylock # lockscreen
      swayidle
      xwayland # for legacy apps
      waybar # status bar
      mako # notification daemon
      kanshi # autorandr
      wob # Wayland Overlay Bar
      gnome3.networkmanagerapplet
      libappindicator
      qt5.qtwayland
      wofi

      wl-clipboard

      slurp
      grim
      sway-contrib.grimshot

      udiskie
      nwg-launchers
      wayvnc
      wf-recorder
    ];
  };

  programs.waybar.enable = true;

  xdg.portal = {
    enable = true;
    # gtkUsePortal = true;
    extraPortals = with pkgs; [
      # xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  systemd.user.services.xdg-desktop-portal.environment = {
    XDG_DESKTOP_PORTAL_DIR = config.environment.variables.XDG_DESKTOP_PORTAL_DIR;
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    # libsForQt5.qtstyleplugins
  ];

  services = {
    pipewire.enable = true;

    redshift = {
      enable = true;
      package = pkgs.redshift-wlr;
      executable = "/bin/redshift-gtk";
    };
  };
}
