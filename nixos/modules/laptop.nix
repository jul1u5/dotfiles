{ config, lib, ... }:

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
      logind.extraConfig = ''
        HandlePowerKey=hibernate
      '';

      upower.enable = true;
      thermald.enable = true;

      auto-cpufreq.enable = false;

      # TODO: Test if this has a negative impact on performance
      # tlp = {
      #   enable = true;
      #   settings = {
      #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
      #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      #   };
      # };

      blueman.enable = true;
    };

    home._ = {
      services = {
        blueman-applet.enable = true;
      };
    };

    programs = {
      light.enable = true;
    };

    user.extraGroups = [
      # 'light' requires the user to be in the 'video' group
      "video"
    ];
  };
}
