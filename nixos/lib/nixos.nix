{ inputs, lib, pkgs, ... }:

with lib;
with lib.my;
let
  system = "x86_64-linux";
in
{
  mkHost = path:
    nixosSystem {
      inherit system;
      specialArgs = { inherit lib inputs system; };
      modules = [
        {
          nixpkgs.pkgs = pkgs;
          networking.hostName = mkDefault (removeSuffix ".nix" (baseNameOf path));
        }
        ../.   # /default.nix
        (import path)
      ];
    };

  mapHosts = dir:
    mapModules dir mkHost;
}
