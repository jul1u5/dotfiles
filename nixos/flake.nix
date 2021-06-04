{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    nur.url = "github:nix-community/NUR";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      inherit (lib.my) mapModules mapModulesRec mapHosts;

      system = "x86_64-linux";

      mkPkgs = pkgs: overlays: import pkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = overlays ++ (lib.attrValues self.overlays);
      };

      pkgs = mkPkgs nixpkgs [
        self.overlay
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

      overlay = final: prev: {
        unstable   = mkPkgs inputs.nixpkgs-master [ ];
        emacs-pkgs = mkPkgs inputs.nixpkgs-unstable [ inputs.emacs-overlay.overlay ];
        my = self.packages."${system}";
      };

      overlays = mapModules ./overlays import;

      packages."${system}" = mapModules ./packages (p: pkgs.callPackage p {});

      nixosModules = mapModulesRec ./modules import;

      nixosConfigurations = mapHosts ./hosts;
    };
}
