{
  inputs,
  lib,
  pkgs,
  ...
}: let
  system = "x86_64-linux";
in {
  mkHost = path:
    lib.nixosSystem {
      inherit system;
      specialArgs = {inherit system lib inputs;};
      modules = [
        {
          nixpkgs = {inherit pkgs;};
          networking.hostName = lib.mkDefault (lib.removeSuffix ".nix" (baseNameOf path));

          imports = lib.my.readModulesToList ../modules;
          environment.etc.current-configuration.source = ../.;
        }
        path
      ];
    };
}
