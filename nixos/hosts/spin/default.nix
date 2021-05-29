{ inputs, lib, pkgs, ... }:

{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    common-pc-laptop
    common-pc-laptop-ssd
    ./hardware-configuration.nix
  ];

  users = {
    defaultUserShell = pkgs.zsh;

    users.julius = {
      isNormalUser = true;

      extraGroups = [
        "adbusers"
        "dialout"
        "docker"
        "input"
        "libvirtd"
        "networkmanager"
        "sway"
        "vboxusers"
        "video"
        "wheel"
        "wireshark"
      ];
    };
  };

  programs = {
    light.enable = true;
    fish.enable = true;
    mtr.enable = true;

    neovim.defaultEditor = true;
  };

  services = {
    locate.enable = true;
    localtime.enable = true;
    rpcbind.enable = true;

    thermald.enable = true;
    tlp.enable = true;
    upower.enable = true;

    blueman.enable = true;

    fwupd.enable = true;

    xserver = {
      enable = true;

      displayManager = {
        gdm.enable = true;
        # lightdm.enable = true;

        defaultSession = "sway";
      };
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;

    pam.services = {
      gdm.enableGnomeKeyring = true;
      lightdm.enableGnomeKeyring = true;
    };
  };


  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_IE.UTF-8";
      LC_MONETARY = "lt_LT.UTF-8";
      LC_PAPER = "lt_LT.UTF-8";
      LC_ADDRESS = "lt_LT.UTF-8";
    };
  };

  environment.variables = {
    BROWSER = "firefox";
  };
}
