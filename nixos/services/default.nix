{
  imports = [
    ./compton.nix
    ./gdm.nix
    ./gnome.nix
    ./input.nix
    ./keyboard.nix
    ./lorri.nix
    ./printing.nix
    # ./redshift.nix
    # ./sway.nix
    # ./xmonad.nix
  ];

  services = {
    localtime.enable = true;
    upower.enable = true;
    rpcbind.enable = true;

    xserver = {
      enable = true;

      videoDrivers = [ "modesetting" ];
      useGlamor = true;

      # deviceSection = ''
      #   Option "DRI" "2"
      #   Option "TearFree" "true"
      # '';

      screenSection = ''
        Option "RandRRotation" "on"
      '';

      desktopManager.xterm.enable = true;
    };
  };
}
