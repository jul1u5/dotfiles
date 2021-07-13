{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.theme;
in
{
  options.modules.theme = {
    theme = {
      package = mkOption {
        type = types.package;
        default = pkgs.materia-theme;
      };
      name = mkOption {
        type = types.str;
        default = "Materia-dark";
      };
    };

    iconTheme = {
      package = mkOption {
        type = types.package;
        default = pkgs.papirus-icon-theme;
      };
      name = mkOption {
        type = types.str;
        default = "Papirus-Dark";
      };
    };

    cursorTheme = {
      package = mkOption {
        type = types.package;
        default = pkgs.paper-icon-theme;
      };
      name = mkOption {
        type = types.str;
        default = "Paper";
      };
    };

    extraPkgs = mkOption {
      type = types.listOf types.package;
      default = [ pkgs.my.materia-kde ];
    };
  };

  config = {
    environment.variables = {
      GTK_THEME = cfg.theme.name;
      QT_STYLE_OVERRIDE = "kvantum";
    };

    user.packages = [
      cfg.theme.package
      cfg.iconTheme.package
      cfg.cursorTheme.package

      pkgs.libsForQt5.qtstyleplugin-kvantum
    ] ++ cfg.extraPkgs;

    services.xserver.displayManager.lightdm = {
      greeters.gtk = {
        inherit (cfg) theme iconTheme cursorTheme;
      };
    };
  };
}
