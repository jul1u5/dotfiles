{
  config,
  lib,
  pkgs,
  ...
}: let
  output2workspace2key = {
    "eDP-1" =
      lib.listToAttrs
      (map
        (ws:
          lib.nameValuePair
          (toString ws)
          (toString (
            if ws == 10
            then 0
            else ws
          )))
        (lib.range 1 10));
    "HDMI-A-1" =
      lib.listToAttrs
      (map
        (ws:
          lib.nameValuePair
          (toString (10 + ws))
          "F${toString ws}")
        (lib.range 1 12));
  };

  colors = rec {
    bg = "#080F11";
    accent = green;
    text = {
      fg = "#FFFFFF";
      bg = "#969A9C";
    };
    red = {
      fg = "#E86886";
      bg = "#2C2128";
    };
    green = {
      fg = "#48D597";
      active-bg = "#16362E";
      bg = "#102422";
    };
    blue = {
      fg = "#4969F6";
      bg = "#142139";
    };
    yellow = {
      fg = "#F5CF65";
      bg = "#2E3024";
    };
  };
in {
  imports = [
    ./waybar
    ./swaync
  ];

  programs = {
    sway = {
      enable = true;
      extraPackages = [];
    };
  };

  hardware.opengl.enable = true;

  security = {
    polkit.enable = true;
  };

  user.packages = with pkgs; [
    swayidle
    swaylock-effects
    autotiling
    swayr

    qt5.qtwayland

    sway-contrib.grimshot
    wdisplays
    gsimplecal
    clipman
    wl-clipboard
    wl-mirror
    wf-recorder
    wofi
    wofi-emoji
    wtype

    # For screen duplication
    wayvnc
    gnome.vinagre
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    # gtkUsePortal = true;
    wlr.enable = true;
  };

  services = {
    pipewire.enable = true;
  };

  environment.sessionVariables = {
    # Run Electron apps inside Wayland
    NIXOS_OZONE_WL = "1";

    # Enable anti-aliasing for Java applications.
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true";
  };

  home._ = home: {
    # Show nm-applet in tray
    xsession.preferStatusNotifierItems = true;

    programs = {
      #   eww = {
      #     enable = true;
      #     configDir = ./eww;
      #     package = pkgs.unstable.eww-wayland;
      #   };
    };

    services = {
      kanshi.enable = true;

      avizo = {
        enable = true;
        settings = {
          default = {
            time = 1.0;
            y-offset = 0.5;
            fade-in = 0.1;
            fade-out = 0.2;
            padding = 10;
          };
        };
      };

      network-manager-applet.enable = true;
      udiskie.enable = true;
      gammastep = {
        # enable = true;
        tray = true;
        provider = "geoclue2";
        temperature.day = 6500;
      };

      kdeconnect = {
        enable = true;
        indicator = true;
      };
    };

    wayland.windowManager.sway = let
      sway-cfg = home.config.wayland.windowManager.sway;
    in {
      enable = true;
      systemd.enable = true;

      wrapperFeatures = {
        gtk = true;
      };

      extraSessionCommands = ''
        # export MOZ_ENABLE_WAYLAND=1
        # export MOZ_DBUS_REMOTE=1

        export QT_QPA_PLATFORM=wayland-egl
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

        # Fix for some Java AWT applications (e.g. Android Studio)
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';

      extraConfig = ''
        ${
          lib.pipe output2workspace2key [
            (lib.mapAttrs (_output: lib.attrNames))
            (lib.mapAttrsToList (output: map (ws: "workspace ${ws} output ${output}")))
            lib.concatLists
            (lib.concatStringsSep "\n")
          ]
        }

        titlebar_border_thickness 0
        titlebar_padding 5 2

        # include /etc/sway/config.d/*
        exec dbus-daemon --session --address=unix:path=$XDG_RUNTIME_DIR/bus

        exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1

        # Toggle squeekboard (on-screen keyboard)
        bindswitch --locked tablet:on  exec 'notify-send "Tablet mode"; busctl call --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b true'
        bindswitch --locked tablet:off exec 'notify-send "Laptop mode"; busctl call --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b false'

        exec systemd-cat -t wl-paste \
          wl-paste -t text --watch clipman store -P

        exec systemd-cat -t swayrd \
          swayrd

        # exec fcitx5 -d --replace

        workspace 1
        exec ${sway-cfg.config.terminal} btop

        workspace 10
        exec spotify

        workspace 11
        exec firefox
      '';

      config = let
        lock = "swaylock -f --screenshots --effect-pixelate 10 --fade-in 1";
      in {
        modifier = "Mod4";

        terminal = "kitty";
        menu = "wofi -S drun --insensitive --allow-images || (exit 255) | xargs swaymsg exec --";

        input = {
          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
          };

          "type:keyboard" = with config.services.xserver; {
            xkb_layout = layout;
            xkb_options = xkbOptions;
          };

          "type:pointer" = {
            accel_profile = "flat"; # Disable mouse acceleration
            # scroll_factor = "2";
          };
        };

        output = {
          "*".bg = "~/Pictures/faro16x9.jpg fill";
        };

        seat.seat0 = {
          xcursor_theme = with home.config.gtk.cursorTheme; "${name} ${toString size}";
        };

        bars = [];

        startup = [
          {
            command = ''
              swayidle -w \
                timeout  600 '${lock} --grace 5' \
                timeout 1200 'swaymsg "output * dpms off"' \
                resume 'swaymsg "output * dpms on"' \
                before-sleep 'playerctl pause' \
                before-sleep '${lock}'
            '';
          }
          {
            # https://github.com/systemd/systemd/issues/5247#issuecomment-471217754
            command = ''
              export XDG_RUNTIME_DIR="/run/user/$(id -u)"
            '';
          }
        ];

        workspaceAutoBackAndForth = true;

        bindkeysToCode = true;

        keybindings = let
          mod = sway-cfg.config.modifier;

          pictures = "\${XDG_PICTURES_DIR:-$HOME/Pictures}";

          swap-workspaces = pkgs.writeShellScript "swap-workspaces.sh" ''
            workspaces=$(swaymsg -t get_workspaces)
            focused_ws=$(echo -E "$workspaces" | jq '.[] | select(.focused) | .name')
            visible_but_unfocused_ws=$(echo -E "$workspaces" | jq '.[] | select(.visible and (.focused | not)) | .name')
            placeholder="__temp"
            message=(
                "move workspace to output up"
                "workspace $visible_but_unfocused_ws"
                "move workspace to output up"
                "rename workspace $focused_ws to $placeholder"
                "rename workspace $visible_but_unfocused_ws to $focused_ws"
                "rename workspace $placeholder to $visible_but_unfocused_ws"
                "workspace $focused_ws"
            )
            swaymsg $(IFS=';'; echo "''${message[*]}")
          '';

          mkWorkspaceBinds = wsToKey:
            lib.mergeAttrs
            (lib.mapAttrs'
              (ws: key:
                lib.nameValuePair
                "${mod}+${key}"
                "workspace ${ws}")
              wsToKey)
            (lib.mapAttrs'
              (ws: key:
                lib.nameValuePair
                "${mod}+Shift+${key}"
                "move container to workspace ${ws}")
              wsToKey);

          workspaceBinds = lib.pipe output2workspace2key [
            lib.attrValues
            (map mkWorkspaceBinds)
            (lib.foldAttrs (cmd: u: assert u == null; cmd) null)
          ];
        in
          lib.mkOptionDefault ({
              "${mod}+Ctrl+${sway-cfg.config.left}" = "move container to output left; focus output left";
              "${mod}+Ctrl+${sway-cfg.config.down}" = "move container to output down; focus output down";
              "${mod}+Ctrl+${sway-cfg.config.up}" = "move container to output up; focus output up";
              "${mod}+Ctrl+${sway-cfg.config.right}" = "move container to output right; focus output right";

              "${mod}+Tab" = "workspace back_and_forth";

              "${mod}+v" = "splith";
              "${mod}+s" = "splitv";
              "${mod}+Shift+s" = "sticky toggle";
              "${mod}+Ctrl+s" = "exec ${swap-workspaces}";

              "${mod}+Shift+r" = "reload";
              "${mod}+Shift+c" = "kill";
              "${mod}+Shift+x" = "exec ${lock}";
              "${mod}+Shift+q" = ''
                exec swaynag -t warning \
                  -m 'Exit?' \
                  -b 'Yes' \
                  'swaymsg exit'
              '';

              "${mod}+p" = "exec swayr switch-window";

              "${mod}+Shift+v" = "exec clipman pick --tool wofi";
              "${mod}+period" = "exec wofi-emoji";

              "XF86AudioPlay" = "exec playerctl play-pause";
              "--locked XF86AudioNext" = "exec playerctl next";
              "XF86AudioPrev" = "exec playerctl previous";

              "Shift+KP_End" = "exec playerctl previous";
              "--locked Shift+KP_Down" = "exec playerctl play-pause";
              "Shift+KP_Next" = "exec playerctl next";

              "Alt+F1" = "exec pamixer --default-source --toggle-mute";

              "Print" = "exec grimshot copy area";
              "Shift+Print" = "exec grimshot copy output";

              "${mod}+Print" = ''
                exec grimshot save area ${pictures}/$(date +%Y-%m-%d_%H-%m-%s).png
              '';
              "${mod}+Shift+Print" = ''
                exec grimshot save output ${pictures}/$(date +%Y-%m-%d_%H-%m-%s).png
              '';

              "--locked XF86AudioRaiseVolume" = "exec volumectl -u up";
              "--locked XF86AudioLowerVolume" = "exec volumectl -u down";
              "--locked XF86AudioMute" = "exec volumectl toggle-mute";
              "--locked XF86AudioMicMute" = "exec volumectl -m toggle-mute";

              "--locked XF86MonBrightnessUp" = "exec lightctl up";
              "--locked XF86MonBrightnessDown" = "exec lightctl down";

              "${mod}+n" = "exec ${pkgs.swaynotificationcenter}/bin/swaync-client -t";
            }
            // workspaceBinds);

        floating = {
          criteria = [
            {title = "^Save File$";}

            {
              app_id = "^firefox$";
              title = "^About Mozilla Firefox$";
            }
            # FIXME: Doesn't work for some reason
            # { app_id = "^firefox"; title = "^Extension: \\(Tree Style Tab\\) - Close tabs\\? — Mozilla Firefox$"; }

            {
              class = "^Vivaldi";
              title = "^Vivaldi Settings";
            }

            {
              class = "^jetbrains-studio$";
              title = "^win0$";
            }

            {
              class = "^Steam$";
              title = "^Friends List$";
            }
            {
              class = "^Steam$";
              title = "^Steam Guard - Computer Authorization Required$";
            }

            {app_id = "^com.usebottles.bottles$";}

            {app_id = "^org.gnome.(Settings|Software|Calculator|Nautilus)$";}

            {app_id = "^zenity$";}
            {app_id = "^nm-connection-editor$";}
            {app_id = "blueman-manager";}
            {app_id = "^wdisplays$";}
            {app_id = "^com.github.wwmm.easyeffects$";}
            {app_id = "^gcolor3$";}
            {app_id = "^org.kde.kdeconnect.daemon$";}
          ];
        };

        window = {
          border = 2;
          hideEdgeBorders = "smart";

          commands = [
            {
              criteria = {app_id = "^(firefox|Chromium)$";};
              command = "inhibit_idle fullscreen";
            }
            {
              criteria = {
                app_id = "^firefox$";
                title = "^Meet - .* - Mozilla Firefox$";
              };
              command = "inhibit_idle visible";
            }
            {
              criteria = {title = "^Picture-in-Picture$";};
              command = "floating enable; sticky enable";
            }
            {
              criteria = {title = "Wine System Tray";};
              command = "move scratchpad";
            }
          ];
        };

        fonts = {
          names = ["monospace"];
          style = "Regular";
          size = 10.0;
        };

        colors = with colors; {
          background = bg;
          focused = {
            background = accent.active-bg;
            border = accent.fg;
            childBorder = accent.fg;
            indicator = red.fg;
            text = accent.fg;
          };
          focusedInactive = {
            background = accent.bg;
            border = accent.bg;
            childBorder = accent.bg;
            indicator = accent.bg;
            text = accent.fg;
          };
          unfocused = {
            background = bg;
            border = bg;
            childBorder = bg;
            indicator = bg;
            text = text.bg;
          };
          urgent = {
            background = red.bg;
            border = red.fg;
            childBorder = red.fg;
            indicator = red.fg;
            text = red.fg;
          };
        };
      };
    };
  };
}
