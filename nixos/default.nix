{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ./cachix.nix ] ++ (lib.my.mapModulesRec' (toString ./modules) import);

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

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
      # "nixpkgs=${./compat}"
      # "nixos-config=${./compat/nixos}"
    ];

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
    };

    # https://github.com/NixOS/nixpkgs/issues/124215
    sandboxPaths = [ "/bin/sh=${pkgs.bash}/bin/sh" ];

    gc.automatic = true;
  };

  fileSystems."/".device = lib.mkDefault "/dev/disk/by-label/nixos";

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
