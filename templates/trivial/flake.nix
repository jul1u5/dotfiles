{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
  };

  outputs = inputs @ {
    flake-parts,
    devshell,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        devshell.flakeModule
      ];

      systems = [
        "x86_64-linux"
      ];

      perSystem = {pkgs, ...}: {
        devshells.default = {
          packages = with pkgs; [
            # TODO: Add packages
          ];
        };
      };
    };
}
