{ config, lib, pkgs, ... }:

{
  qt5.enable = false;

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gnome";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  user.packages = with pkgs; [
    pkgs.unstable.adw-gtk3
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
        size = 11;
        package = pkgs.overpass;
      };
    };

    home = {
      pointerCursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;

        gtk.enable = true;
        x11.enable = true;
      };
    };

    xdg = {
      dataFile = lib.mkMerge [
        {
          "themes" = {
            source = "${pkgs.unstable.adw-gtk3}/share/themes";
            recursive = true;
          };
        }

        # Fix icons for Flatpak apps
        (with home.config.gtk.iconTheme; {
          "icons/${name}".source = "${package}/share/icons/${name}";
        })
        (with home.config.home.pointerCursor; {
          "icons/${name}".source = "${package}/share/icons/${name}";
        })
      ];

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
