{ pkgs, ... }:

{
  nixpkgs.config.allowBroken = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
    gnomeExtensions.dash-to-panel
    gnomeExtensions.remove-dropdown-arrows
    gnomeExtensions.system-monitor
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnomeExtensions.impatience
  ];

  services = {
    xserver.desktopManager = { gnome3.enable = true; };

    udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

    gnome3.sushi.enable = true;
  };
}
