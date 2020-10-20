{ pkgs, ... }:

{
  # environment.variables.MESA_LOADER_DRIVER_OVERRIDE = "iris";

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware = {
    # enableRedistributableFirmware = true;
    # cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];

      # extraPackages = with pkgs; [
      #   vaapiIntel
      #   vaapiVdpau
      #   libvdpau-va-gl
      #   intel-media-driver
      # ];
      # extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };

    pulseaudio = {
      enable = true;
      support32Bit = true;

      daemon.config = { enable-deferred-volume = "no"; };
    };
  };
}
