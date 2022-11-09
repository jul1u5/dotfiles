{ lib, inputs, pkgs, ... }:

{
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  nix = {
    # package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "root" "@wheel" ];

    nixPath = lib.mapAttrsToList (name: path: "${name}=${path}") {
      nixpkgs = pkgs.path;
      unstable = inputs.nixpkgs-unstable;
      inherit (inputs) home-manager;
      nixos-config = "/etc/current-configuration/compat/nixos";
      repl = "/etc/current-configuration/repl.nix";
    };

    registry = {
      system.flake = inputs.self;
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };

    gc.automatic = true;
  };
}
