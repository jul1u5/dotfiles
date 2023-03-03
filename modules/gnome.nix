{ lib, pkgs, ... }:

{
  services = {
    xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    # Cannot use TLP alongisde power-profiles-daemon
    power-profiles-daemon.enable = false;

    gnome.games.enable = true;
  };

  user.packages = lib.attrValues {
    inherit (pkgs.gnome)
      gnome-tweaks
      ;

    inherit (pkgs.gnomeExtensions)
      system-monitor
      appindicator
      gsconnect
      # pop-shell
      # pop-launcher-super-key
      ;
  };
}
