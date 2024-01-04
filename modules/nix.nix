{
  lib,
  inputs,
  pkgs,
  ...
}: {
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = true;
    };

    nixPath = lib.mapAttrsToList (name: path: "${name}=${path}") {
      nixpkgs = pkgs.path;
      unstable = inputs.nixos-unstable;
      inherit (inputs) home-manager;

      nixos-config = "/etc/current-configuration/compat/nixos";
      repl = "/etc/current-configuration/repl.nix";
    };

    registry = {
      system.flake = inputs.self;
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixos-unstable;
    };
  };
}
