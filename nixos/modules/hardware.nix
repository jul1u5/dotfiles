{
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  hardware = {
    enableRedistributableFirmware = true;

    opengl.enable = true;

    pulseaudio = {
      enable = true;
      daemon.config = { enable-deferred-volume = "no"; };
    };
  };
}
