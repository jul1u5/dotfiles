{ pkgs, ... }:

{
  programs = {
    neovim.defaultEditor = true;

    thefuck.enable = true;
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
    bitwarden-cli
    gnupg
    pass

    # System Monitor
    bottom
    htop
    procs

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
    gdu
    graphviz
    hexyl
    hyperfine
    inotify-tools
    jq
    nixos-shell
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
    youtube-dl
    zoxide

    # Misc
    glxinfo
    gnome.librsvg
    imagemagick
    inxi
    libfsm
    libinput
    libnotify
    lshw
    moreutils
    pciutils
    strace
    usbutils
    lsof
  ];
}
