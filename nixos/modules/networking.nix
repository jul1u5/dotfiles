{ pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    dhcpcd.enable = false;

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

  systemd.services = {
    systemd-udev-settle.enable = false;
    NetworkManager-wait-online.enable = false;
  };

  environment.systemPackages = with pkgs; [
    curl
    nmap-graphical
    xh
    openvpn
    socat
    traceroute
    wget
  ];
}
