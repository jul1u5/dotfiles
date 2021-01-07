{ pkgs, ... }:

{
  # environment.variables.MESA_LOADER_DRIVER_OVERRIDE = "iris";

  # nixpkgs.config.packageOverrides = pkgs: {
  #   vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  # };

  hardware = {
    enableRedistributableFirmware = true;

    opengl = {
      enable = true;
      driSupport32Bit = true;
    };

    pulseaudio = {
      enable = true;
      support32Bit = true;

      daemon.config = { enable-deferred-volume = "no"; };
    };
  };
}
