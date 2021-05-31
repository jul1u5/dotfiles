{
  inputs = {
    # nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/aa8c68053a228b7052ac908d573f7c347f02d5af";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";

    # nixpkgs-emacs.url = "github:NixOS/nixpkgs/1f77a4c8c74bbe896053994836790aa9bf6dc5ba";
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

        config = {
          allowUnfree = true;
        };

        overlays = overlays ++ (lib.attrValues self.overlays);
      };

      pkgs = mkPkgs nixpkgs [
        # inputs.nixpkgs-wayland.overlay
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
        unstable   = mkPkgs inputs.nixpkgs-unstable [ ];
        emacs-pkgs = mkPkgs inputs.nixpkgs [ inputs.emacs-overlay.overlay ];
        my = self.packages."${system}";
      };

      overlays = mapModules ./overlays import;

      packages."${system}" = mapModules ./packages (p: pkgs.callPackage p {});

      nixosModules = mapModulesRec ./modules import;

      nixosConfigurations = mapHosts ./hosts;
    };
}
