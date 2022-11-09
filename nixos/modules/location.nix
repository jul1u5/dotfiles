{ config, lib, ...}:

{
  location = {
    # 2.5.7 version of geoclue2 does not work:
    # https://gitlab.freedesktop.org/geoclue/geoclue/-/issues/143

    # https://github.com/NixOS/nixpkgs/issues/130555
    # provider = "geoclue2";

    # latitude = 54.898521;
    # longitude = 23.903597;
  };

  services = {
    geoclue2 = {
      enable = true;
      # GNOME has its own agent and disables the demo agent
      enableDemoAgent = lib.mkForce true;

      appConfig = {
        "gammastep" = {
          isAllowed = true;
          isSystem = false;
          users = [ (toString config.user.uid) ];
        };
      };
    };
  };

  services = {
    tzupdate.enable = true;

    # localtime doesn't seem to work
    # localtime.enable = true;
  };
}
