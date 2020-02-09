{ pkgs, ... }:

let switchWorkspaceExtension = pkgs.callPackage ./switch-workspace.nix { };
in {
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.remove-dropdown-arrows
    gnomeExtensions.system-monitor
    gnomeExtensions.appindicator
    gnomeExtensions.impatience
    switchWorkspaceExtension
  ];

  services = {
    xserver.desktopManager = {
      gnome3 = {
        enable = true;
        extraGSettingsOverrides = ''
          [org.gnome.desktop.default-applications.terminal]
          exec='${pkgs.kitty}/bin/kitty'
        '';
      };
    };

    gnome3.sushi.enable = true;
  };
}
