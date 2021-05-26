{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core
    bat
    binutils
    colordiff
    exa
    fd
    file
    psmisc
    ripgrep
    tree

    # Archivers
    atool
    zip
    unzip
    unrar

    # Security
    bitwarden-cli
    gnupg
    pass

    # System Monitor
    bottom
    htop

    # Calculator
    bc
    libqalculate

    # Git
    delta
    gh
    gitAndTools.gitFull
    gnome.libsecret

    # File explorer
    ranger
    lf
    nnn

    # Nix
    cachix
    manix
    niv
    nix-index
    nix-prefetch-git
    nixpkgs-fmt
    patchelf

    # Xorg
    xbrightness
    xclip
    xorg.xev
    xorg.xeyes

    # Filesystem
    nfs-utils
    sshfs

    # Fun
    cmatrix
    cowsay
    figlet
    fortune
    lolcat
    neofetch

    # Tools
    appimage-run
    dragon-drop
    fzf
    graphviz
    hexyl
    httpie
    hyperfine
    inotify-tools
    jq
    ncdu
    pandoc
    radare2
    rlwrap
    shellcheck
    starship
    stow
    thefuck
    tldr
    tmux
    translate-shell
    trash-cli
    youtube-dl

    # Misc
    glxinfo
    gnome.librsvg
    imagemagick
    inxi
    libfsm
    libinput
    lshw
    moreutils
    nodejs
    pciutils
    strace
    usbutils
    lsof
  ];
}
