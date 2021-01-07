{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    fallout-grub-theme = {
      url = "github:shvchk/fallout-grub-theme";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, emacs-overlay, fallout-grub-theme }:
    let
      inherit (nixpkgs) lib;

      system = "x86_64-linux";

      mkPkgs = pkgs: import pkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # pkgs = mkPkgs nixpkgs;
      unstable = import nixpkgs-unstable {
        inherit system;
        overlays = [ emacs-overlay.overlay ];
        config.allowUnfree = true;
      };

      hardwareModules = lib.attrValues {
        inherit (nixos-hardware.nixosModules)
          common-cpu-intel
          common-pc-laptop
          common-pc-laptop-ssd
          ;
      };
    in
    {
      nixosConfigurations.spin = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = hardwareModules ++ [ (import ./.) ];
        extraArgs = {
          inherit nixpkgs nixpkgs-unstable unstable fallout-grub-theme;
        };
      };
    };
}
