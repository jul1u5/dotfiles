{ pkgs, ... }:

{
  programs = {
    neovim.defaultEditor = true;
  };

  users.defaultUserShell = pkgs.zsh;

  user.packages = with pkgs; [
    # Core
    bat
    binutils
    colordiff
    exa
    fd
    file
    psmisc
    ripgrep
    sd
    tree

    # Archivers
    atool
    zip
    unzip
    unrar

    # Security
    gnupg
    pass

    # System Monitor
    btop
    htop
    procs

    # Calculator
    bc
    libqalculate

    # Git
    delta
    difftastic
    gh
    gitAndTools.gitFull
    libsecret

    # File explorer
    ranger
    lf
    nnn

    # Nix
    cachix
    manix
    niv
    unstable.nix-output-monitor
    nix-prefetch-git
    nix-update
    nixos-shell
    nixpkgs-fmt
    patchelf
    statix
    deadnix

    # Fun
    cmatrix
    cowsay
    figlet
    fortune
    lolcat
    neofetch

    # Tools
    appimage-run
    dig
    entr
    exiftool
    fx
    fzf
    gdu
    graphviz
    hexyl
    hyperfine
    inotify-tools
    jc
    jq
    pandoc
    radare2
    rlwrap
    shellcheck
    starship
    stow
    tldr
    tmux
    translate-shell
    trash-cli
    xdragon
    youtube-dl
    zoxide

    # Misc
    glxinfo
    librsvg
    imagemagick
    inxi
    libfsm
    libinput
    libnotify
    lshw
    moreutils
    pciutils
    strace
    ltrace
    usbutils
    lsof
  ];
}
