{ config, options, lib, ... }:

with lib;
{
  options = {
    user = mkOption {
      type = types.attrs;
      default = { };
    };

    home = mkOption {
      type = types.attrs;
    };
  };

  config = {
    users.users.${config.user.name} = mkAliasDefinitions options.user;

    user = let name = "julius"; in
      {
        inherit name;
        description = "Julius";
        extraGroups = [ "wheel" ];
        isNormalUser = true;
        home = "/home/${name}";
        group = "users";
        uid = 1000;
      };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.${config.user.name} = mkAliasDefinitions options.home;
    };

    home.home.stateVersion = config.system.stateVersion;
  };
}
