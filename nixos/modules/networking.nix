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
}
