{ inputs, lib, ... }:

{
  imports = lib.attrValues {
    inherit (inputs.nixos-hardware.nixosModules)
      common-cpu-intel
      common-pc-laptop
      common-pc-laptop-ssd
      ;
  } ++ [
    ./hardware-configuration.nix
  ];

  location.provider = "geoclue2";

  programs = {
    light.enable = true;
    fish.enable = true;
    mtr.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  services = {
    locate.enable = true;
    localtime.enable = true;
    rpcbind.enable = true;

    upower.enable = true;

    tlp.enable = true;
    thermald.enable = true;

    xserver = {
      enable = true;

      displayManager = {
        # gdm.enable = true;
        lightdm.enable = true;

        defaultSession = "sway";
      };

      videoDrivers = [ "modesetting" ];
      useGlamor = true;

      deviceSection = ''
        Option "TearFree" "true"
      '';
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;

    pam.services = {
      gdm.enableGnomeKeyring = true;
      lightdm.enableGnomeKeyring = true;
    };
  };


  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_IE.UTF-8";
      LC_MONETARY = "lt_LT.UTF-8";
      LC_PAPER = "lt_LT.UTF-8";
      LC_ADDRESS = "lt_LT.UTF-8";
    };
  };

  environment.variables = {
    BROWSER = "firefox";
  };

  nix = {
    trustedUsers = [ "root" "julius" ];
    allowedUsers = [ "root" "@wheel" ];
  };
}
