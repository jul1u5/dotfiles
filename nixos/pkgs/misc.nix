{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    binutils
    cmatrix
    cowsay
    figlet
    fortune
    imagemagick
    imwheel
    killall
    lolcat
    lshw
    moreutils
    nfs-utils
    nixfmt
    nmap-graphical
    openvpn
    patchelf
    pciutils
    playerctl
    shellcheck
    sshfs
    trash-cli
    usbutils
    xbrightness
    xclip
    xorg.xev
    xorg.xeyes
  ];
}
