{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    bat
    binutils
    cmatrix
    cowsay
    dmenu
    exa
    fd
    feh
    figlet
    fortune
    fzf
    gotop
    imagemagick
    imwheel
    jq
    killall
    libqalculate
    lolcat
    lshw
    moreutils
    ncdu
    neofetch
    nfs-utils
    nmap-graphical
    nox
    openvpn
    pciutils
    playerctl
    ranger
    ripgrep
    rofi
    scrot
    sshfs
    starship
    stow
    tldr
    tmux
    trash-cli
    tree
    usbutils
    vimHugeX
    xbrightness
    xclip
    xorg.xev
    xorg.xeyes
  ];
}