{ config, options, lib, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options = with lib; with types; {
    user = mkOption {
      type = attrs;
      default = { };
      description = ''
        An alias for passing option to the default user via the option
        <option>users.user.<name></option>.
      '';
    };

    home = {
      file = mkOption {
        type = attrs;
        default = { };
        description = "Files managed by home-manager's <option>home.file</option>";
      };
      configFile = mkOption {
        type = attrs;
        default = { };
        description = "Files managed by home-manager's <option>xdg.configFile</option>";
      };
      _ = mkOption {
        type = attrs;
        default = { };
        description = "For passing arbitrary configuration to user's home-manager config";
      };
    };
  };

  config = {
    home._ = {
      home.stateVersion = config.system.stateVersion;
      home.file = lib.mkAliasDefinitions options.home.file;
      xdg = {
        enable = true;
        userDirs.enable = true;
        configFile = lib.mkAliasDefinitions options.home.configFile;
      };
    };

    users.users.${config.user.name} = lib.mkAliasDefinitions options.user;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.${config.user.name} = lib.mkAliasDefinitions options.home._;
    };
  };
}
