{ pkgs, ... }:

{
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.remove-dropdown-arrows
    gnomeExtensions.topicons-plus
    gnomeExtensions.impatience
  ];

  services.xserver.desktopManager = { gnome3 = { enable = true; }; };

  nixpkgs.overlays = [ (self: super: { gnome-terminal = super.kitty; }) ];
}
