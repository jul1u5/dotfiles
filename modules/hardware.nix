{
  hardware = {
    enableRedistributableFirmware = true;
  };

  services = {
    fwupd.enable = true;
  };

  user.extraGroups = [
    # Access USB devices, e.g., /dev/ttyUSB0
    "dialout"
  ];
}
