{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # useDHCP = false;
    # wicd.enable = true;

    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };
}
