{ config, pkgs, ... }:

let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in {
  imports =
    [ ./hardware-configuration.nix
      ./cachix.nix
      ./nixos.nix
      ./vscode.nix
      (builtins.fetchTarball {
        sha256 = "12riba9dlchk0cvch2biqnikpbq4vs22gls82pr45c3vzc3vmwq9";
        url = "https://github.com/msteen/nixos-vsliveshare/archive/e6ea0b04de290ade028d80d20625a58a3603b8d7.tar.gz";
      })
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    plymouth.enable = true;
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        editor = false;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      grub.useOSProber = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # useDHCP = false;
    # wicd.enable = true;

    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  hardware = {
    enableRedistributableFirmware = true;
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;

    cpu.intel.updateMicrocode = true;
  };

  sound.enable = true;

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # time.timeZone = "Europe/Vilnius";
  location = {
    provider = "geoclue2";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      firefox.enableGnomeExtensions = true;
    };
    latestPackages = [
      "vscode"
      "vscode-extensions"
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    file
    binutils
    usbutils
    git
    gnupg
    htop
    ncdu
    zip
    unzip

    xclip
    xbrightness
    xsecurelock
    clipmenu

    neofetch
    gotop
    gparted
    stow
    feh
    dmenu
    rofi
    trayer
    taffybar

    ripgrep
    fd
    bat
    exa

    firefox
    vscode
    emacs

    plata-theme
    paper-icon-theme
    papirus-icon-theme

    # libfprint

    (all-hies.unstableFallback.selection { selector = p: { inherit (p) ghc864 ghc865; }; })
    (import (builtins.fetchTarball "https://github.com/hercules-ci/ghcide-nix/tarball/master") {}).ghcide-ghc865
  ];

  vscode.user = "julius";
  vscode.homeDir = "/home/julius";
  vscode.extensions = with pkgs.vscode-extensions; [
    ms-vscode.cpptools
  ];

  environment.variables = {
    BROWSER = "firefox";

    # Touch screen in firefox
    MOZ_USE_XINPUT2 = "1";

    # rofi
    TERMINAL = "alacritty";
  };

  # GTK icon theme
  # environment.profileRelativeEnvVars.XCURSOR_PATH = [ "/share/icons" ];
  environment.sessionVariables = {
    GDK_PIXBUF_MODULE_FILE = "$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)";
    GTK_DATA_PREFIX = [ "${config.system.path}" ];
    # GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
  };

  fonts = {
    fonts = with pkgs; [
      corefonts
      fira-code
      fira-code-symbols
      font-awesome-ttf
      freefont_ttf
      google-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      overpass
    ];

    enableDefaultFonts = true;

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Overpass" "Noto Color Emoji" ];
        monospace = [ "Fira Code" "Fira Code Symbol" "Noto Sans Mono CJK SC"];
      };
    };
  };

  programs = {
    light.enable = true;
    vim.defaultEditor = true;
    fish.enable = true;
    sway.enable = true;
    slock.enable = true;
    dconf.enable = true;
    mtr.enable = true;
    adb.enable = true;
    gnupg.agent = { enable = true; enableSSHSupport = true; };
  };

  virtualisation = {
    docker.enable = true;
    # virtualbox.host = {
    #   enable = true;
    #   enableExtensionPack = true;
    # };
  };

  services = {
    dbus = {
      socketActivated = true;
      packages = with pkgs; [ gnome3.dconf gnome2.GConf ];
    };

    localtime.enable = true;
    upower.enable = true;
    # fprintd.enable = true;
    openssh.enable = true;

    postgresql.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };

    avahi = {
      enable = true;
      nssmdns = true;
    };

    # logind.lidSwitch = "lock";

    redshift = {
      enable = true;
      temperature.day = 6500;
    };

    vsliveshare = {
      enable = true;
      enableWritableWorkaround = true;
      enableDiagnosticsWorkaround = true;
      extensionsDir = "/home/julius/.vscode/extensions";
    };

    xserver = {
      enable = true;
      layout = "us,lt";
      xkbOptions = "grp:shifts_toggle,eurosign:e,ctrl:nocaps,compose:rctrl";

      displayManager = {
        gdm.enable = true;
        extraSessionFilePackages = [ pkgs.sway ];
      };

      desktopManager = {
        xterm.enable = false;
        gnome3 = {
          enable = true;
          extraGSettingsOverridePackages = with pkgs; [
            gnome3.gnome-terminal
          ];
          extraGSettingsOverrides = ''
            [org.gnome.desktop.default-applications]
            terminal="exec kitty" 
          '';
        };
      };

      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          extraPackages = haskellPackages: [
            haskellPackages.xmonad-contrib
            haskellPackages.xmonad-extras
            haskellPackages.xmonad
          ];
        };
        default = "xmonad";
      };

      libinput = {
        enable = true;
        naturalScrolling = true;
        disableWhileTyping = true;
        accelProfile = "flat";
      };
      config = ''
        Section "InputClass"
          Identifier "mouse accel"
          Driver "libinput"
          MatchIsPointer "yes"
          Option "AccelProfile" "flat"
          Option "AccelSpeed" "0"
        EndSection
      '';

      multitouch = {
        enable = true;
        invertScroll = true;
        ignorePalm = true;
      };

      screenSection = ''
        Option "RandRRotation" "on"
      '';

      wacom.enable = true;
      modules = [ pkgs.xf86_input_wacom ];
    };

    compton = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 4;
      vSync = true;
      settings = {
        paint-on-overlay = true;
        glx-no-stencil = true;
        glx-no-rebind-pixmap = true;
        glx-swap-method = "buffer-age";
        sw-opti = true;
        xrender-sync-fence = true;
      };
    };
  };

  systemd.services."xsecurelock" = {
    description = "Lock X session using xsecurelock";
    wantedBy = [ "suspend.target" ];
    before = [ "suspend.target" ];

    environment = {
      DISPLAY = ":0";
      XAUTHORITY = "/home/julius/.Xauthority";
    };

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.xsecurelock}/bin/xsecurelock";
    };
  };

  users.users.julius = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "adbusers" "docker" "vboxusers" "sway" ];
    shell = pkgs.fish;
  };

  nix.allowedUsers = [ "root" "@wheel" ];

  security = {
    sudo.wheelNeedsPassword = false;
    # pam.services = {
    #   login.fprintAuth = true;
    #   xscreensaver.fprintAuth = true;
    # };
  };

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
