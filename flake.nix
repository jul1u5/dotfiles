{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    # hyprland.url = "github:hyprwm/Hyprland";

    spicetify-nix.url = "github:the-argus/spicetify-nix";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cornelis = {
      url = "github:isovector/cornelis";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv.url = "github:cachix/devenv/v0.4";

    fallout-grub-theme = {
      url = "github:shvchk/fallout-grub-theme";
      flake = false;
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    mkPkgs = pkgs: extraOverlays:
      import pkgs {
        inherit system;
        overlays = lib.attrValues self.overlays ++ extraOverlays;
        config.allowUnfree = true;
      };

    pkgs = mkPkgs nixpkgs [
      # inputs.nur.overlay
      # inputs.emacs-overlay.overlay
    ];

    lib = nixpkgs.lib.extend (final: _prev: {
      my = import ./lib {
        inherit self inputs pkgs;
        lib = final;
      };
    });

    # my-packages = lib.mapAttrs (_name: f: pkgs.callPackage f {}) (lib.my.readModules ./packages);
    my-packages = {
      kvlibadwaita = pkgs.callPackage ./packages/kvlibadwaita {};
      onagre = pkgs.callPackage ./packages/onagre {};
      pop-launcher = pkgs.callPackage ./packages/pop-launcher {};
      rot8 = pkgs.callPackage ./packages/rot8 {};
      tlpui = pkgs.python3Packages.callPackage ./packages/tlpui {};
      typst-lt = pkgs.python3Packages.callPackage ./packages/typst-lt {};
    };
  in {
    inherit lib;

    packages.${system} = my-packages;

    legacyPackages.${system} = pkgs;

    overlays =
      lib.mapAttrs (_name: import) (lib.my.readModules ./overlays)
      // {
        default = _final: _prev: {
          unstable = mkPkgs inputs.nixos-unstable [];
          my = my-packages;
          # hyprland = inputs.hyprland.packages.${system}.default;
        };
      };

    nixosModules = lib.my.readModules ./modules;

    nixosConfigurations = lib.mapAttrs (_name: lib.my.mkHost) (lib.my.readModules ./hosts);

    templates = {
      trivial = {
        path = ./templates/trivial;
        description = "A very basic flake using numtide's flake-utils";
      };
    };

    devShells.${system}.default = with pkgs.unstable;
      mkShell {
        packages = [
          ghc
          lua

          # haskell-language-server
          lua-language-server
        ];
      };
  };

  nixConfig = {
    extra-substituters = [
      "https://devenv.cachix.org"
      # "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
