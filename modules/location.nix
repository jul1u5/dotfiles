{ config, lib, ...}:

{
  location = {
    # https://github.com/NixOS/nixpkgs/issues/130555
    provider = "geoclue2";
  };

  services = {
    geoclue2 = {
      # GNOME has its own agent and disables the demo agent
      enableDemoAgent = lib.mkForce true;

      appConfig = {
        "gammastep" = {
          isAllowed = true;
          isSystem = true;
          users = [ (toString config.user.uid) ];
        };
      };
    };
  };

  services = {
    # tzupdate.enable = true;
    localtimed.enable = true;
  };
}
