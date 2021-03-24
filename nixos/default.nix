{ config, pkgs, inputs, ... }:
{
  imports = [
    ./cachix.nix
    ./hardware-configuration.nix
    ./modules
    ./pkgs
    ./services
  ];

  networking.hostName = "spin";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_IE.UTF-8";
      LC_MONETARY = "lt_LT.UTF-8";
      LC_PAPER = "lt_LT.UTF-8";
      LC_ADDRESS = "lt_LT.UTF-8";
    };
  };

  sound.enable = true;
  location.provider = "geoclue2";

  programs = {
    light.enable = true;
    fish.enable = true;
    mtr.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';

    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "nixos-config=/etc/nixos"
    ];

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
    };

    trustedUsers = [ "root" "julius" ];
    allowedUsers = [ "root" "@wheel" ];

    gc.automatic = true;
  };

  security.sudo.wheelNeedsPassword = false;

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
