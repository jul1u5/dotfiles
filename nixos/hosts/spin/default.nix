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
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  services = {
    fwupd.enable = true;
    earlyoom.enable = true;
    localtime.enable = true;
    locate.enable = true;
  };

  networking = {
    # useDHCP = false;
    # interfaces = {
    #   wlp1s0.useDHCP = true;
    #   enp0s20f0u3u1u4.useDHCP = true;
    # };
  };

  user = {
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
}
