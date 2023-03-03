{ config, lib, pkgs, ... }:

{
  qt5.enable = false;

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gnome";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  user.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
  ];

  home._ = home: {
    gtk = {
      enable = true;

      gtk3.extraConfig = {
        gtk-theme-name = "adw-gtk3-dark";
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      font = {
        name = "Overpass Regular";
        package = pkgs.overpass;
        size = 11;
      };
    };

    home = {
      pointerCursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;

        gtk.enable = true; # Applies the settings to gtk.cursorTheme
        x11.enable = true; # Necessary for X11 apps like Spotify
      };
    };

    xdg = {
      dataFile = {
        "themes" = {
          source = "${pkgs.adw-gtk3}/share/themes";
          recursive = true;
        };
      };

      configFile = {
        "qt5ct/qt5ct.conf".text = ''
          [Appearance]
          icon_theme=${home.config.gtk.iconTheme.name}
          style=kvantum-dark
        '';

        "Kvantum/kvantum.kvconfig".text = ''
          theme=KvLibadwaitaDark
        '';

        "Kvantum/KvLibadwaita".source =
          "${pkgs.my.kvlibadwaita}/share/Kvantum/KvLibadwaita";
      };
    };
  };
}
