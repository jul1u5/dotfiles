{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # HACK: For some reason, sometimes Hydra (or Cachix) doesn't want to provide emacsPgtkGcc binary.
    # emacs-overlay.url = "https://github.com/nix-community/emacs-overlay/archive/master@%7Byesterday%7D.tar.gz";
    # emacs-overlay.url = "https://github.com/nix-community/emacs-overlay/archive/443a8d4881752222d9e1eed515e5f259c6785b6e.tar.gz";

    nix-alien = {
      # TODO: Try unpinning
      url = "github:thiagokokada/nix-alien/b47b2d88b2d0d825efd309f7fd58c76df34f7048";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";

      mkPkgs = pkgs: extraOverlays: import pkgs {
        inherit system;
        overlays = extraOverlays ++ (lib.attrValues self.overlays);
        config.allowUnfree = true;
      };

      pkgs = mkPkgs nixpkgs [
        inputs.emacs-overlay.overlay
        inputs.nur.overlay
        inputs.nix-alien.overlay
        self.overlays.default
      ];

      lib = nixpkgs.lib.extend (final: prev: {
        my = import ./lib {
          inherit inputs pkgs;
          lib = final;
        };
      });
    in
    {
      inherit lib;

      packages.${system} = lib.my.mapDir (f: pkgs.callPackage f { }) ./packages;

      legacyPackages.${system} = pkgs;

      overlays = lib.my.mapDir import ./overlays // {
        default = final: prev: {
          unstable = mkPkgs inputs.nixpkgs-unstable [ ];
          master = mkPkgs inputs.nixpkgs-master [ ];
          my = self.packages.${system};
        };
      };

      nixosModules = lib.my.mapDir import ./modules;

      nixosConfigurations = lib.my.mapHosts ./hosts;

      templates = {
        path = ./templates/trivial;
        description = "A very basic flake using numtide's flake-utils";
      };
    };
}
