{ pkgs, ... }:

{
  services = {
    xserver.desktopManager.gnome.enable = true;

    gnome.sushi.enable = true;
    power-profiles-daemon.enable = false;
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.remove-dropdown-arrows
    gnomeExtensions.system-monitor
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnomeExtensions.impatience
  ];
}
