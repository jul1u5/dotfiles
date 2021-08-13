{ config, options, lib, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options = {
    user = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };

    home = lib.mkOption {
      type = lib.types.attrs;
    };
  };

  config = {
    users.users.${config.user.name} = lib.mkAliasDefinitions options.user;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.${config.user.name} = lib.mkAliasDefinitions options.home;
    };

    home.home.stateVersion = config.system.stateVersion;
  };
}
