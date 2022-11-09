{ inputs, lib, pkgs, ... }:

let
  system = "x86_64-linux";
  mkHost = path:
    lib.nixosSystem {
      inherit system;
      specialArgs = { inherit system lib inputs; };
      modules = [
        {
          nixpkgs = { inherit pkgs; };
          networking.hostName = lib.mkDefault (lib.removeSuffix ".nix" (baseNameOf path));
        }
        ../configuration.nix
        (import path)
      ];
    };
in
{
  mapHosts = lib.my.mapDir mkHost;
}
