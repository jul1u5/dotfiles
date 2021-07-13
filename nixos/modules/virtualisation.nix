{ pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  user.packages = with pkgs; [
    docker-compose
    virt-manager
  ];

  user.extraGroups = [ "docker" "libvirtd" ];
}
