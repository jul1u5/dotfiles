{ pkgs, ... }:

{
  # # Use virtualbox module from a stable channel to (hopefully) not cause recompilation.
  # disabledModules = [ "virtualisation/virtualbox-host.nix" ];

  # imports = [
  #   <nixos-stable/nixos/modules/virtualisation/virtualbox-host.nix>
  # ];

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;

    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;

      # package = (import <nixos-stable> { allowUnfree = true; }).virtualbox;
    };
  };

  environment.systemPackages = with pkgs; [ docker-compose ];
}
