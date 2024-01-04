{
  lib,
  config,
  pkgs,
  ...
}: {
  services = {
    flatpak.enable = true;
  };

  system.fsPackages = [pkgs.bindfs];

  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = ["ro" "resolve-symlinks" "x-gvfs-hide"];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = ["/share/fonts"];
    };
  in {
    # Create an FHS mount to support flatpak host icons/fonts
    # "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
    "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
  };

  home._ = home: {
    xdg = {
      # Fix icon and cursor themes for Flatpak apps
      dataFile = lib.mkMerge [
        (with home.config.gtk.iconTheme; {
          "icons/${name}".source = "${package}/share/icons/${name}";
        })
        (with home.config.gtk.cursorTheme; {
          "icons/${name}".source = "${package}/share/icons/${name}";
        })
      ];
    };
  };
}
