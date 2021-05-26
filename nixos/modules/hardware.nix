{
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  hardware = {
    enableRedistributableFirmware = true;

    opengl.enable = true;
  };
}
