{ config, pkgs, ... }:

{
  imports = [ ./cachix.nix ./hardware-configuration.nix ./modules ./pkgs ./services ];

  networking.hostName = "spin";

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;
  location = { provider = "geoclue2"; };

  programs = {
    light.enable = true;
    fish.enable = true;
    vim.defaultEditor = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "root" "julius" ];
    allowedUsers = [ "root" "@wheel" ];
  };

  security = {
    sudo.wheelNeedsPassword = false;
    pam.services = { gdm.enableGnomeKeyring = true; };
  };

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
