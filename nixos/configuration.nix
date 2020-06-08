{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./modules ./pkgs ./services ];

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
    trustedUsers = [ "root" "julius" ];
    allowedUsers = [ "root" "@wheel" ];

    binaryCaches = [ " https://nixcache.reflex-frp.org" ];
    binaryCachePublicKeys =
      [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
  };

  security = {
    sudo.wheelNeedsPassword = false;
    pam.services = { gdm.enableGnomeKeyring = true; };
  };

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
