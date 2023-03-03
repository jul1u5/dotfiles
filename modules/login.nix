_:

{
  security = {
    pam.services = {
      gdm.enableGnomeKeyring = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      displayManager = {
        # defaultSession = "sway";
      };
    };
  };
}
