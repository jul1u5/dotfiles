{ pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    virt-manager
  ];
}
