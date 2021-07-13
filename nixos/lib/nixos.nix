{ inputs, lib, pkgs, ... }:

let
  system = "x86_64-linux";
  mkHost = path:
    lib.nixosSystem {
      inherit system;
      specialArgs = { inherit lib inputs system; };
      modules = [
        {
          nixpkgs.pkgs = pkgs;
          networking.hostName = lib.mkDefault (lib.removeSuffix ".nix" (baseNameOf path));
        }
        ../. # /default.nix
        (import path)
      ];
    };
in
{
  mapHosts = lib.my.mapModules mkHost;
}
