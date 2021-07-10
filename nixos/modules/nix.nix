{ pkgs, inputs, ... }:

{
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';

    trustedUsers = [ "root" "@wheel" ];

    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "nixos-config=/etc/current-configuration/compat/nixos"
    ];

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };

    gc.automatic = true;
  };
}
