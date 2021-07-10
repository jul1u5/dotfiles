{ config, lib, pkgs, ... }:

{
  security = {
    pam.services = {
      gdm.enableGnomeKeyring = true;
    };
  };

  services.xserver = {
    enable = true;

    displayManager = {
      defaultSession = "sway";

      gdm.enable = true;
    };
  };
}
