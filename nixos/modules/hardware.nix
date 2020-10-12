{ pkgs, ... }:

{
  # environment.variables.MESA_LOADER_DRIVER_OVERRIDE = "iris";

  # nixpkgs.config.packageOverrides = pkgs: {
  #   vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  # };

  hardware = {
    # enableRedistributableFirmware = true;
    # cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport32Bit = true;

      # package = (pkgs.mesa.override {
      #   galliumDrivers = [ "nouveau" "virgl" "swrast" "iris" ];
      # }).drivers;

      # extraPackages = with pkgs; [
      #   vaapiIntel
      #   vaapiVdpau
      #   libvdpau-va-gl
      #   intel-media-driver
      # ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };

    pulseaudio = {
      enable = true;
      support32Bit = true;

      daemon.config = { enable-deferred-volume = "no"; };
    };
  };
}
