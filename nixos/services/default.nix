{
  imports = [
    # ./compton.nix
    ./gdm.nix
    ./gnome.nix
    ./input.nix
    ./keyboard.nix
    ./lorri.nix
    # ./mpd.nix
    ./printing.nix
    # ./redshift.nix
    ./sway.nix
    # ./xmonad.nix
  ];

  services = {
    localtime.enable = true;
    rpcbind.enable = true;
    upower.enable = true;
    tlp.enable = true;
    thermald.enable = true;

    xserver = {
      enable = true;

      videoDrivers = [ "modesetting" ];
      useGlamor = true;

      deviceSection = ''
        Option "TearFree" "true"
      '';

      screenSection = ''
        Option "RandRRotation" "on"
      '';
    };
  };
}
