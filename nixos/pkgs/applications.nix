{ pkgs, ... }:

{
  programs = { wireshark.enable = true; };

  environment.systemPackages = with pkgs; [
    alacritty
    blender
    discord
    dmenu
    emacs
    feh
    gimp
    gitAndTools.hub
    gnome3.nautilus
    google-chrome
    gparted
    httpie
    inkscape
    kitty
    krita
    libqalculate
    libreoffice
    # lutris
    lxappearance
    lynx
    mpv
    mplayer
    ncdu
    octave
    pandoc
    pavucontrol
    postman
    psensor
    radare2
    rofi
    scrot
    spotify
    starship
    steam
    thefuck
    tmux
    translate-shell
    transmission-gtk
    vimHugeX
    wireshark
    ytop
  ];
}
