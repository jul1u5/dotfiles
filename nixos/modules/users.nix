{ pkgs, ... }:

{
  users.users.julius = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "networkmanager" "adbusers" "docker" "vboxusers" "sway" ];
    shell = pkgs.fish;
  };
}
