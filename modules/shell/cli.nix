{
  inputs,
  pkgs,
  ...
}: {
  programs = {
    neovim.defaultEditor = true;
  };

  user.packages = with pkgs; [
    # Core
    bat
    binutils
    colordiff
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
    (nvtop.override {
      amd = false;
      nvidia = false;
    })

    # Calculator
    bc
    libqalculate

    # Git
    gitAndTools.gitFull
    git-lfs
    libsecret
    gh
    delta
    difftastic
    lazygit

    # File explorer
    ranger
    lf
    nnn
    xplr

    # Nix
    cachix
    manix
    niv
    unstable.nix-output-monitor
    nix-prefetch-git
    nix-update
    nixos-shell
    alejandra
    patchelf
    statix
    deadnix
    inputs.devenv.packages.${system}.devenv

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
    tealdeer
    tmux
    translate-shell
    trash-cli
    xdragon
    youtube-dl
    google-cloud-sdk

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
