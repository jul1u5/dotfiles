{ inputs, ... }:

{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    common-pc-laptop
    common-pc-laptop-ssd
    ./hardware-configuration.nix
    ./sway.nix
  ];

  modules = {
    laptop.enable = true;
    boot.theme = "fallout";
  };

  boot = {
    kernelParams = [
      # Issues with network card
      "pcie_aspm=off"
    ];

    extraModprobeConfig = ''
      options ath10k_core skip_otp=y
    '';
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  services = {
    earlyoom.enable = true;
    # fprintd.enable = true;

    xserver = {
      wacom.enable = true;
    };
  };

  # systemd.services.fprintd.environment.G_MESSAGES_DEBUG = "all";

  networking = {
    useDHCP = false;
    interfaces = {
      wlp1s0.useDHCP = true;
      # enp0s20f0u3u1u4.useDHCP = true;
    };

    networkmanager = {
      # Becomes wifi.powersave=2 in the config
      # See: https://github.com/NixOS/nixpkgs/blob/c132d0837dfb9035701dcd8fc91786c605c855c3/nixos/modules/services/networking/networkmanager.nix#L555
      wifi.powersave = false;
    };
  };

  powerManagement.cpuFreqGovernor = "performance";

  user = {
    name = "julius";
    description = "Julius";

    isNormalUser = true;
    uid = 1000;

    extraGroups = [
      "wheel"
    ];
  };

  home._ = {
    dconf = {
      enable = true;

      settings."org/gnome/settings-daemon/plugins/media-keys" = {
        play     = [ "<Shift>KP_Down" ];
        next     = [ "<Shift>KP_Next" ];
        previous = [ "<Shift>KP_End"  ];
      };
    };
  };
}
