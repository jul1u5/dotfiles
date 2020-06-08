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

      package = (import (pkgs.fetchzip {
        name = "old-nixpkgs";
        url =
          "https://github.com/NixOS/nixpkgs/archive/0a11634a29c1c9ffe7bfa08fc234fef2ee978dbb.tar.gz";
        sha256 = "0vj5k3djn1wlwabzff1kiiy3vs60qzzqgzjbaiwqxacbvlrci10y";
      }) { }).mesa.drivers;

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
