{
  inputs,
  pkgs,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    common-pc-laptop
    common-pc-laptop-ssd
    ./hardware-configuration.nix
    ./sway.nix
  ];

  modules = {
    laptop.enable = true;
    boot.theme = "fallout";
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  boot = {
    kernelParams = [
      # Issues with network card
      "pcie_aspm=off"
    ];

    extraModprobeConfig = ''
      options ath10k_core skip_otp=y
    '';
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  # Fingerprint reader doesn't work consistently
  # services.fprintd.enable = true;
  # systemd.services.fprintd.environment.G_MESSAGES_DEBUG = "all";

  systemd.oomd.enable = false;
  # FIXME: systemd-oomd doesn't work
  services.earlyoom.enable = true;

  services = {
    xserver = {
      wacom.enable = true;
    };
  };

  networking = {
    # networkmanager = {
    #   # Becomes wifi.powersave=2 in the config
    #   # See: https://github.com/NixOS/nixpkgs/blob/c132d0837dfb9035701dcd8fc91786c605c855c3/nixos/modules/services/networking/networkmanager.nix#L555
    #   wifi.powersave = false;
    #   wifi.scanRandMacAddress = false;
    # };
  };

  environment.etc."wireplumber/main.lua.d/51-suspend-timeout.lua" = {
    text = ''
      table.insert(alsa_monitor.rules, {
        matches = {
          { -- Matches all sources.
            { "node.name", "matches", "alsa_input.*" },
          },
          { -- Matches all sinks.
            { "node.name", "matches", "alsa_output.*" },
          },
        },
        apply_properties = { ["session.suspend-timeout-seconds"] = 0 },
      })
    '';
  };

  # See: https://github.com/NixOS/nixpkgs/issues/189851
  systemd.user.services.restart-xdg-desktop-portal = {
    description = "Restart xdg-desktop-portal";
    script = ''
      sleep 60
      systemctl restart --user xdg-desktop-portal.service
    '';
    wantedBy = ["graphical-session.target"];
  };

  hardware.opengl = {
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
    ];
  };

  powerManagement.cpuFreqGovernor = "performance";

  environment.wordlist.enable = true;

  user = {
    name = "julius";
    description = "Julius";

    isNormalUser = true;
    uid = 1000;

    extraGroups = [
      "wheel"
    ];
  };

  home._ = {
    dconf = {
      enable = true;

      settings = {
        "org/gnome/settings-daemon/plugins/media-keys" = {
          play = ["<Shift>KP_Down"];
          next = ["<Shift>KP_Next"];
          previous = ["<Shift>KP_End"];
        };
        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = ["<Super><Alt>h"];
          toggle-tiled-right = ["<Super><Alt>l"];
        };
        "org/gnome/desktop/wm/keybindings" = {
          maximize = ["<Super><Alt>k"];
          unmaximize = ["<Super><Alt>j"];
          toggle-maximized = ["<Super>f"];
          minimize = ["<Super>comma"];
          close = ["<Super>q" "<Alt>F4"];

          switch-to-workspace-left = ["<Super>Left" "<Super>h"];
          switch-to-workspace-right = ["<Super>Right" "<Super>l"];
          switch-to-workspace-down = ["<Super>Down" "<Super>j"];
          switch-to-workspace-up = ["<Super>Up" "<Super>k"];

          move-to-workspace-left = ["<Super><Shift>h"];
          move-to-workspace-right = ["<Super><Shift>l"];
          move-to-workspace-down = [];
          move-to-workspace-up = [];

          move-to-monitor-up = ["<Super><Ctrl>k"];
          move-to-monitor-down = ["<Super><Ctrl>j"];
          move-to-monitor-left = ["<Super><Ctrl>h"];
          move-to-monitor-right = ["<Super><Ctrl>l"];

          switch-to-workspace-1 = ["<Super>1"];
          switch-to-workspace-2 = ["<Super>2"];
          switch-to-workspace-3 = ["<Super>3"];
          switch-to-workspace-4 = ["<Super>4"];

          move-to-workspace-1 = ["<Super><Shift>1"];
          move-to-workspace-2 = ["<Super><Shift>2"];
          move-to-workspace-3 = ["<Super><Shift>3"];
          move-to-workspace-4 = ["<Super><Shift>4"];
        };
        "org/gnome/shell/keybindings" = {
          open-application-menu = [];
          toggle-overview = [];
          switch-to-application-1 = [];
          switch-to-application-2 = [];
          switch-to-application-3 = [];
          switch-to-application-4 = [];
          switch-to-application-5 = [];
          switch-to-application-6 = [];
          switch-to-application-7 = [];
          switch-to-application-8 = [];
          switch-to-application-9 = [];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/emoji/"
          ];
          screensaver = ["<Super>Escape"];
          rotate-video-lock-static = [];
          home = ["<Super>e"];
          email = [];
          www = [];
          terminal = [];
        };
        "org/gnome/mutter/wayland/keybindings" = {
          restore-shortcuts = [];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty" = {
          binding = "<Super>Return";
          command = "kitty"; # TODO: use configured "default"
          name = "Open Kitty";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/emoji" = {
          binding = "<Super>period";
          command = "flatpak run it.mijorus.smile";
          name = "Open emoji picker";
        };
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
