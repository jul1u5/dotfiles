{
  config,
  pkgs,
  ...
}: {
  boot = {
    kernelParams = ["intel_iommu=on"];
    # kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
    # extraModprobeConfig = "options vfio-pci ids=8086:3ea0,8086:9dc8";
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        # runAsRoot = false;
        swtpm.enable = true;
        verbatimConfig = ''
          user = "${config.user.name}"
        '';
      };
    };

    docker = {
      # enable = true;
      rootless.enable = true;
    };

    # waydroid.enable = true;
    # lxd.enable = true;
  };

  environment.sessionVariables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };

  user.packages = with pkgs; [
    docker-compose
    virt-manager
  ];

  user.extraGroups = ["docker" "libvirtd"];
}
