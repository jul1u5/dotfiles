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

      users.${config.user.name} = lib.mkAliasDefinitions options.home;
    };

    home.home.stateVersion = config.system.stateVersion;
  };
}
