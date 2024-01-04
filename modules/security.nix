{
  config,
  lib,
  ...
}: {
  security = {
    # Enable Trusted Platform Module 2.0
    tpm2.enable = true;
  };

  services = {
    # Protects against rogue USB devices
    # (disabled for now, because USB mouse stops working)
    # usbguard.enable = true;
  };

  # Mounts /tmp on RAM
  boot.tmp.useTmpfs = lib.mkDefault true;
  boot.tmp.cleanOnBoot = lib.mkDefault (!config.boot.tmp.useTmpfs);

  # See https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix
  # From description:
  #   Whether to allow editing the kernel command-line before
  #   boot. It is *recommended to set this to false*, as it allows
  #   gaining root access by passing init=/bin/sh as a kernel
  #   parameter. However, it is enabled by default for backwards
  #   compatibility.
  boot.loader.systemd-boot.editor = false;
}
