{ pkgs, ... }:

{
  services = {
    xserver.desktopManager.gnome3.enable = true;

    gnome3.sushi.enable = true;
  };

  programs.qt5ct.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
    gnomeExtensions.remove-dropdown-arrows
    gnomeExtensions.system-monitor
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnomeExtensions.impatience
  ];
}
