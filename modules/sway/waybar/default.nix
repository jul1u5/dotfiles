{ pkgs, ... }:

{
  home._ = {
    programs.waybar = {
      enable = true;

      systemd = {
        enable = true;
        target = "sway-session.target";
      };

      style = ./style.css;

      settings = {
        mainBar = {
          layer = "bottom";
          height = 26;

          modules-left = [
            "sway/workspaces"
            "sway/mode"
            # "custom/scratchpad"
            # "custom/spotify"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "sway/language"
            "temperature"
            "cpu#freq"
            "cpu"
            "memory"
            "pulseaudio"
            "pulseaudio#mic"
            "idle_inhibitor"
            "battery"
            "tray"
          ];

          "sway/workspaces" = {
            disable-markup = true;
            disable-scroll = true;
            format = "{name}";
          };
          "sway/mode" = {
            format = "<span style=\"italic\">{}</span>";
          };
          "sway/language" = {
            format = "{}";
          };
          "custom/scratchpad" = {
            interval = 1;
            return-type = "json";
            format = "{icon}";
            format-icons = {
              "one" = "";
              "many" = "";
            };
            exec = pkgs.writeShellScript "scratchpad.sh" ''
              tooltip=$(swaymsg -r -t get_tree | jq -r 'recurse(.nodes[]) | first(select(.name=="__i3_scratch")) | .floating_nodes | .[] | "\(.app_id) | \(.name)"')
              count=$(echo -n "$tooltip" | grep -c '^')

              if (( "$count" == 0 )); then
                exit 1
              elif (( "$count" == 1 )); then
                class="one"
              elif (( "$count" > 1 )); then
                class="many"
              else
                class="unknown"
              fi

              printf '{"text": "%s", "class": "%s", "alt": "%s", "tooltip": "%s"}\n' "$count" "$class" "$class" "''${tooltip//$'\n'/'\n'}"
            '';
            on-click = "swaymsg 'scratchpad show'";
          };
          "custom/spotify" = {
            interval = 1;
            format = "{}";
            escape = true;
            on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
            exec = pkgs.writeShellScript "mediaplayer.sh" ''
              player_status=$(playerctl status 2> /dev/null)
              if [ "$player_status" = "Playing" ]; then
                  echo " $(playerctl metadata artist) - $(playerctl metadata title)"
              elif [ "$player_status" = "Paused" ]; then
                  echo " "
              fi
            '';
            exec-if = "${pkgs.procps}/bin/pgrep spotify";
            max-length = 50;
          };

          clock = {
            format = "{:%H:%M}";
            on-click = "gsimplecal";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
          };

          temperature = {
            thermal-zone = 8;
            critical-threshold = 85;
            format-critical = "{temperatureC}°C ";
            format = "{temperatureC}°C ";
          };

          cpu = {
            interval = 10;
            format = "{usage:3}% ({load})  ";
          };
          "cpu#freq" = {
            interval = 10;
            format = "{max_frequency:4} GHz  ";
          };
          memory = {
            interval = 10;
            format = "{used:.1f} GB  ";
          };

          pulseaudio = {
            format = "{volume:3}% {icon}";
            format-bluetooth = "{icon}";
            format-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = " ";
              default = [ "" " " ];
            };
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            on-scroll-up = "";
            on-scroll-down = "";
          };
          "pulseaudio#mic" = {
            format = "{format_source}";
            format-source = "";
            format-source-muted = "";
            on-click = "${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            on-scroll-up = "";
            on-scroll-down = "";
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = " ";
              deactivated = " ";
            };
          };

          battery = {
            bat = "BAT0";
            adapter = "BAT0";
            states = {
              warning = 30;
              critical = 20;
            };
            format = "{capacity:3}% {icon}";
            format-charging = "{capacity:3}% ";
            format-plugged = "";
            format-full = "";
            format-icons = [ " " " " " " " " " " ];
          };

          tray = {
            icon-size = 16;
            spacing = 16;
          };
        };
      };
    };
  };
}
