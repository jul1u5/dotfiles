# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.useOSProber = true;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;

    nameservers = [ "1.1.1.1" "1.0.0.1" ];

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };

  hardware = {
    enableRedistributableFirmware = true;
    pulseaudio.enable = true;
  };

  sound.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vilnius";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
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
    xcompmgr
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
  ];

  fonts = {
    # enableDefaultFonts = true;
    
    fonts = with pkgs; [
      google-fonts
      fira-code
      overpass
      font-awesome-ttf
    ];

    fontconfig = {
      # penultimate.enable = false;
      defaultFonts = {
	sansSerif = [ "Overpass" ];
        monospace = [ "Fira Code" ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    fish.enable = true;
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

    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "eurosign:e,ctrl:nocaps,compose:rctrl";

      # displayManager.sddm.enable = true;
      desktopManager = {
        # plasma5.enable = true;
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

      wacom.enable = true;

      modules = [pkgs.xf86_input_wacom ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.julius = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  security = {
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
