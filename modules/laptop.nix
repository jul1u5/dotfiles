{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.laptop;
in {
  options = {
    modules.laptop = {
      enable = lib.mkOption {
        type = with lib.types; bool;
        default = false;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # hardware = {
    #   bluetooth = {
    #     powerOnBoot = false;
    #   };
    # };

    # Has issues with unresponsive mouse connected via USB
    powerManagement.powertop.enable = true;
    user.packages = with pkgs; [powertop lm_sensors];

    services = {
      logind = {
        lidSwitch = "suspend-then-hibernate";
        extraConfig = ''
          HandlePowerKey=hibernate
        '';
      };

      upower.enable = true;
      thermald.enable = true;

      # auto-cpufreq.enable = true;

      # tlp = {
      #   enable = true;
      #   settings = {
      #     CPU_BOOST_ON_AC = 1;
      #     CPU_BOOST_ON_BAT = 0;
      #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
      #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      #     INTEL_GPU_MIN_FREQ_ON_BAT = 300;
      #     INTEL_GPU_MAX_FREQ_ON_BAT = 300;
      #     INTEL_GPU_BOOST_FREQ_ON_BAT = 300;

      #     INTEL_GPU_MIN_FREQ_ON_AC = 300;
      #     INTEL_GPU_MAX_FREQ_ON_AC = 1150;
      #     INTEL_GPU_BOOST_FREQ_ON_AC = 1150;
      #   };
      # };

      blueman.enable = true;
    };

    home._ = {
      services = {
        # blueman-applet.enable = true;
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
