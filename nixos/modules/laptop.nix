{ config, lib, pkgs, ... }:

let cfg = config.modules.laptop;
in
{
  options = {
    modules.laptop = {
      enable = lib.mkOption {
        type = with lib.types; bool;
        default = false;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      upower.enable = true;
      thermald.enable = true;
      tlp = {
        enable = true;

        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        };
      };

      blueman.enable = true;

      logind.extraConfig = ''
        HandlePowerKey=suspend
      '';
    };

    programs = {
      light.enable = true;
    };

    user.extraGroups = [
      # To use 'light' the user must be in the 'video' group
      "video"
    ];
  };
}
