{
  networking = {
    networkmanager.enable = true;
    # useDHCP = false;
    # wicd.enable = true;

    nameservers = [ "1.1.1.1" "1.0.0.1" ];

    firewall.allowedTCPPortRanges = [{
      from = 1716;
      to = 1764;
    }];
  };
}
