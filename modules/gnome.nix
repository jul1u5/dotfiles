{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    # Cannot use TLP alongisde power-profiles-daemon
    # power-profiles-daemon.enable = false;

    gnome.games.enable = true;
  };

  # Configure GDM.
  # This is done according to this suggestion:
  # https://github.com/NixOS/nixpkgs/pull/107850#pullrequestreview-980865873
  #
  # Seems there's an issue with home-manager though:
  # https://github.com/nix-community/home-manager/issues/4352
  nix.settings.allowed-users = ["gdm"];
  home-manager.users.gdm = let
    home-config = config.home-manager.users.${config.user.name};
  in
    {lib, ...}: {
      gtk = {
        enable = true;
        inherit (home-config.gtk) iconTheme font;
      };

      home = {
        inherit (config.system) stateVersion;
        inherit (home-config.home) pointerCursor;
        file.".config/monitors.xml".source = ./monitors.xml;
      };

      dconf.settings = {
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
        };
      };
    };

  user.packages = lib.attrValues {
    inherit
      (pkgs)
      #pop-launcher
      
      ;

    inherit
      (pkgs.gnome)
      dconf-editor
      gnome-tweaks
      ;

    inherit
      (pkgs.gnomeExtensions)
      system-monitor-next
      appindicator
      gsconnect
      caffeine
      #pop-shell
      
      #pop-launcher-super-key
      
      ;
  };
}
