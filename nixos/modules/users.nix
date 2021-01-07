{ pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;

    users.julius = {
      isNormalUser = true;

      extraGroups = [
        "adbusers"
        "dialout"
        "docker"
        "input"
        "libvirtd"
        "networkmanager"
        "sway"
        "vboxusers"
        "video"
        "wheel"
        "wireshark"
      ];
    };
  };
}
