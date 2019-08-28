{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./nixos.nix
      # (builtins.fetchTarball {
      #   sha256 = "12riba9dlchk0cvch2biqnikpbq4vs22gls82pr45c3vzc3vmwq9";
      #   url = "https://github.com/msteen/nixos-vsliveshare/archive/e6ea0b04de290ade028d80d20625a58a3603b8d7.tar.gz";
      # })
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.useOSProber = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;

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

  time.timeZone = "Europe/Vilnius";

  nixpkgs.config.allowUnfree = true;

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
    libfprint

    xclip
    xscreensaver
    xsettingsd
    xbrightness

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
  ];

  environment.variables = {
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
      google-fonts
      fira-code
      overpass
      font-awesome-ttf
    ];

    fontconfig = {
      penultimate.enable = false;
      defaultFonts = {
        sansSerif = [ "Overpass" ];
        monospace = [ "Fira Code" ];
      };
    };
  };

  programs = {
    vim.defaultEditor = true;
    fish.enable = true;
    slock.enable = true;
    dconf.enable = true;
    mtr.enable = true;
    gnupg.agent = { enable = true; enableSSHSupport = true; };
  };

  services = {
    nixosManual.showManual = true;

    locate.enable = true;
    openssh.enable = true;
    printing.enable = true;
    upower.enable = true;
    fprintd.enable = true;

    dbus.packages = [ pkgs.gnome3.dconf ];

    # logind.lidSwitch = "lock";

    # vsliveshare = {
    #   enable = true;
    #   enableWritableWorkaround = true;
    #   enableDiagnosticsWorkaround = true;
    #   extensionsDir = "/home/julius/.vscode/extensions";
    # };

    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "us,lt";
      xkbOptions = "grp:shifts_toggle,eurosign:e,ctrl:nocaps,compose:rctrl";

      displayManager.lightdm = {
        enable = true;
        greeters.gtk = {
          enable = true;
          theme = {
            package = pkgs.plata-theme;
            name = "Plata-Noir";
          };
          iconTheme = {
            package = pkgs.papirus-icon-theme;
            name = "Papirus-Dark";
          };
          cursorTheme = {
            package = pkgs.paper-icon-theme;
            name = "Paper";
          };
        };
      };

      desktopManager = {
        gnome3.enable = true;
        xterm.enable = false;
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

      # Enable touchpad support.
      libinput = {
        enable = true;
        naturalScrolling = true;
        disableWhileTyping = true;
      };

      multitouch = {
        enable = true;
        invertScroll = true;
        ignorePalm = true;
      };

      screenSection = ''
        Option "RandRRotation" "on"
      '';

      wacom.enable = true;
      modules = [pkgs.xf86_input_wacom ];
    };

    compton = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 4;
      vSync = "opengl";
      extraOptions = ''
        paint-on-overlay = true;
        glx-no-stencil = true;
        glx-no-rebind-pixmap = true;
        glx-swap-method = "buffer-age";
        sw-opti = true;
        xrender-sync-fence = true;
      '';
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.julius = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  nix.allowedUsers = [ "root" "@wheel" ];

  security = {
    sudo.wheelNeedsPassword = false;
    pam.services = {
      login.fprintAuth = true;
      xscreensaver.fprintAuth = true;
    };
  };

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
