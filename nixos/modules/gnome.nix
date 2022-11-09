{ pkgs, ... }:

{
  services = {
    xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    power-profiles-daemon.enable = false;

    gnome = {
      sushi.enable = true;
      games.enable = true;
    };
  };

  user.packages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.system-monitor
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnomeExtensions.pop-shell
  ];
}
