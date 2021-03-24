{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/1f77a4c8c74bbe896053994836790aa9bf6dc5ba";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    emacs-overlay.url = "github:nix-community/emacs-overlay/dcb4f8e97b3a6f215e8a30bc01028fc67a4015e7";

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;

      system = "x86_64-linux";

      hardwareModules = lib.attrValues {
        inherit (inputs.nixos-hardware.nixosModules)
          common-cpu-intel
          common-pc-laptop
          common-pc-laptop-ssd
          ;
      };

      overlayModule = { ... }: {
        nixpkgs.overlays = [
          inputs.emacs-overlay.overlay
        ];
      };
    in
    {
      nixosConfigurations.spin = lib.nixosSystem {
        inherit system;
        # pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        modules = hardwareModules ++ [ overlayModule (import ./.) ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
}
