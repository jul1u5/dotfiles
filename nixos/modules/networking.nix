{ pkgs, ... }:

{
  networking = {
    networkmanager = {
      enable = true;

      insertNameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];

      logLevel = "TRACE";
    };

    firewall = {
      # From https://nixos.wiki/wiki/WireGuard
      # > [...] the default configuration of the NixOS firewall will
      # > block the traffic because of rpfilter.
      checkReversePath = false; # maybe "loose" also works, untested

      allowedTCPPortRanges = [
        { from = 1716; to = 1764; } # KDE Connect
      ];
    };
  };

  programs = {
    # ncurses-based traceroute
    mtr.enable = true;

    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  services = {
    # Used by NFS
    rpcbind.enable = true;

    # Used by nautilus
    gvfs.enable = true;

    avahi = {
      enable = true;
      nssmdns = true;
    };
  };

  environment.systemPackages = with pkgs; [
    nfs-utils
    cifs-utils
  ];

  user.packages = with pkgs; [
    curl
    socat
    traceroute
    wget

    openvpn

    nmap
    sshfs

    # HTTPie in Rust
    xh
  ];

  user.extraGroups = [
    "networkmanager"
    "wireshark"
  ];
}
