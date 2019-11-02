{ config, pkgs, ... }:

{
  imports = [
    ./hardware
    ./modules
    ./pkgs
    ./services
    ./cachix.nix
  ];

  sound.enable = true;

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  location = {
    provider = "geoclue2";
  };

  # GTK icon theme
  # environment.profileRelativeEnvVars.XCURSOR_PATH = [ "/share/icons" ];
  environment.sessionVariables = {
    GDK_PIXBUF_MODULE_FILE = "$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)";
    GTK_DATA_PREFIX = [ "${config.system.path}" ];
    # GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
  };

  programs = {
    light.enable = true;
    vim.defaultEditor = true;
    fish.enable = true;
    mtr.enable = true;
    gnupg.agent = { enable = true; enableSSHSupport = true; };
  };

  nix.allowedUsers = [ "root" "@wheel" ];

  security = {
    sudo.wheelNeedsPassword = false;
    # pam.services = {
    #   login.fprintAuth = true;
    #   xscreensaver.fprintAuth = true;
    # };
  };

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
