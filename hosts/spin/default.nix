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

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
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

  # Fingerprint reader doesn't work consistently
  # services.fprintd.enable = true;
  # systemd.services.fprintd.environment.G_MESSAGES_DEBUG = "all";

  systemd.oomd.enable = false;
  # FIXME: systemd-oomd doesn't work
  services.earlyoom.enable = true;

  services = {
    xserver = {
      wacom.enable = true;
    };
  };

  networking = {
    # networkmanager = {
    #   # Becomes wifi.powersave=2 in the config
    #   # See: https://github.com/NixOS/nixpkgs/blob/c132d0837dfb9035701dcd8fc91786c605c855c3/nixos/modules/services/networking/networkmanager.nix#L555
    #   wifi.powersave = false;
    #   wifi.scanRandMacAddress = false;
    # };
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
        play = [ "<Shift>KP_Down" ];
        next = [ "<Shift>KP_Next" ];
        previous = [ "<Shift>KP_End" ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
