{ pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [ 8080 ];
    firewall.allowedTCPPortRanges = [
      # KDE Connect
      {
        from = 1716;
        to = 1764;
      }
    ];
  };

  programs = {
    wireshark.enable = true;
    mtr.enable = true;
  };

  services = {
    rpcbind.enable = true;
  };

  user.packages = with pkgs; [
    curl
    nmap-graphical
    xh
    openvpn
    socat
    traceroute
    wget
  ];

  user.extraGroups = [
    "networkmanager"
    "wireshark"
  ];
}
