# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/67f0e459-f4e0-411b-9d73-e29054d473db";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6271-BD46";
      fsType = "vfat";
    };

  fileSystems."/mnt/windows" =
    { device = "/dev/disk/by-uuid/227672AC76728079";
      fsType = "ntfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/aa7aba94-ef0d-49e1-a34b-b9074f90b3ce"; }
    ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
