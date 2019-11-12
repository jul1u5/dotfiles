{
  imports = [
    ./compton.nix
    ./gdm.nix
    ./gnome.nix
    ./input.nix
    ./keyboard.nix
    ./printing.nix
    ./sway.nix
    ./xmonad.nix
  ];

  services = {
    localtime.enable = true;
    upower.enable = true;
    # openssh.enable = true;

    postgresql.enable = true;

    redshift = {
      enable = true;
      temperature.day = 6500;
    };

    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;

      screenSection = ''
        Option "RandRRotation" "on"
      '';
    };
  };
}
