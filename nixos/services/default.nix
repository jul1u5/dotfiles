{
  imports = [
    ./gnome.nix
    ./input.nix
    ./keyboard.nix
    ./lorri.nix
    ./printing.nix
    ./sway.nix
  ];

  security.pam.services = {
    gdm.enableGnomeKeyring = true;
    lightdm.enableGnomeKeyring = true;
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
        lightdm = {
          enable = true;
          greeters = {
            # gtk.enable = false;
            gtk.theme.name = "Materia:dark";
            # enso.enable = true;
          };
        };

        defaultSession = "sway";
      };

      videoDrivers = [ "modesetting" ];
      useGlamor = true;

      deviceSection = ''
        Option "TearFree" "true"
      '';
    };
  };
}
