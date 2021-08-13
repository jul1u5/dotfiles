{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:rycee/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nur.url = "github:nix-community/NUR";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";

      mkPkgs = pkgs: overlays: import pkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = overlays ++ (lib.attrValues self.overlays);
      };

      pkgs = mkPkgs nixpkgs [
        self.overlay
        inputs.emacs-overlay.overlay
      ];

      lib = nixpkgs.lib.extend (final: prev: {
        my = import ./lib {
          inherit pkgs inputs;
          lib = final;
        };
      });
    in
    {
      inherit lib;

      packages."${system}" = lib.my.mapModules (p: pkgs.callPackage p {}) ./packages;

      overlay = final: prev: {
        unstable = mkPkgs inputs.nixpkgs-master [ ];
        my = self.packages."${system}";
      };

      overlays = lib.my.mapModules import ./overlays;

      nixosModules = lib.my.mapModulesRec import ./modules;

      nixosConfigurations = lib.my.mapHosts ./hosts;
    };
}
