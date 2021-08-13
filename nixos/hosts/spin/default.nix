{ inputs, lib, pkgs, ... }:

{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    common-pc-laptop
    common-pc-laptop-ssd
    ./hardware-configuration.nix
  ];

  modules = {
    laptop.enable = true;
    boot.theme = "fallout";
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  services = {
    earlyoom.enable = true;
  };

  networking = {
    useDHCP = false;
    interfaces = {
      wlp1s0.useDHCP = true;
      enp0s20f0u3u1u4.useDHCP = true;
    };
  };

  user = {
    name = "julius";
    description = "Julius";

    isNormalUser = true;
    uid = 1000;

    extraGroups = [
      "wheel"
    ];
  };
}
