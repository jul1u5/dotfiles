{ pkgs, ... }:

{
  users = {
    users.julius = {
      isNormalUser = true;
      shell = pkgs.zsh;

      extraGroups = [
        "adbusers"
        "docker"
        "input"
        "networkmanager"
        "sway"
        "video"
        "wheel"
        "wireshark"
      ];
    };
  };
}
