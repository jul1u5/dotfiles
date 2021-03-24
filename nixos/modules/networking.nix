{
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  networking = {
    networkmanager.enable = true;

    dhcpcd.enable = false;

    # useDHCP = false;
    # interfaces.wlp1s0.useDHCP = true;
    # interfaces.enp0s20f0u3u1u4.useDHCP = true;

    firewall.allowedTCPPorts = [ 8080 ];
    firewall.allowedTCPPortRanges = [
      # KDE Connect
      {
        from = 1716;
        to = 1764;
      }
    ];
  };
}
