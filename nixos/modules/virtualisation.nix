{ pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;

    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  environment.systemPackages = with pkgs; [ docker-compose ];
}
