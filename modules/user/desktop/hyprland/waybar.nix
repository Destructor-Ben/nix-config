{ pkgs, theme, ... }:
{
  programs.waybar = {
    enable = true;

    settings = {
      main = {
        layer = "bottom";
        position = "top";
        spacing = theme.padding;

        modules-left = [
          "image#nixos"
          "cpu"
          "load"
          "memory"
          "temperature"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "tray"
          # TODO: bluetooth
          # TODO: wifi
          "keyboard-state"
          "backlight"
          "wireplumber"
          "battery"
          "clock"
          "custom/notifications"
        ];

        "image#nixos" = {
          path = "/home/ben/nix-config/img/Nix.svg";
          size = 24;
          on-click = "kitty --hold fastfetch";
        };

        cpu = {
          format = " {usage}%";
          tooltip = false;
        };
        load = {
          format = " {load1}/{load5}/{load15}";
          tooltip = false;
        };
        memory = {
          format = " {percentage}% ({used}/{total} GiB)";
          tooltip = false;
        };
        temperature = {
          thermal-zone = 0;
          format-icons = ["" "" "" "" ""];
          format = "{icon} {temperatureC}°C";
          tooltip = false;
        };

        # TODO: fix icons
        # TODO: fix tooltips
        tray = {
          reverse-direction = true;
          spacing = theme.padding;
          icon-size = 12;
          show-passive-items = true;
        };
        keyboard-state = {
          "numlock" = true;
          "capslock" = true;
          "format" = "{name} {icon}";
          "format-icons" = {
            "locked" = "";
            "unlocked" = "";
          };
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "󰃠" "󰃝" "󰃞" ];
          tooltip = false;
        };
        wireplumber = {
          format = "{format_source}{icon} {volume}%";
          format-muted = "{format_source} {volume}%";
          format-icons = [ "" "" "" ];
          format-source = "";
          format-source-muted = "󰍭 ";
          tooltip = false;
        };
        battery = {
          states = {
            warning = 25;
            critical = 10;
          };
          format = "{icon} {capacity}%";
          format-charging = "{icon}󱐋 {capacity}%";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          tooltip = false;
        };
        clock = {
          format = "{:%a %d %b %I:%M %p}";
          tooltip = false;
        };
        "custom/notifications" = {
          exec = "count=$(swaync-client -c); [ \"$count\" -eq 0 ] && echo \"󰂜\" || echo \"󰂚\"";
          interval = 1;
          format = "{}";
          on-click = "swaync-client -t";
          tooltip = false;
        };
      };
    };

    # TODO: add shadows?
    style =
    ''
    * {
      font-family: "${theme.fonts.ui}";
      font-size: 12px;
      color: ${theme.colors.base};

      box-shadow: none;
      text-shadow: none;
      border: none;
      border-radius: 0;
      transition-duration: 0s;
    }

    window#waybar {
      background-color: transparent;
      border: none;
    }

    .modules-left, .modules-center, .modules-right {
      margin-top: ${toString theme.padding}px;
      background-color: transparent;
      border: none;
    }

    .modules-left {
      margin-left: ${toString theme.padding}px;
    }

    .modules-right {
      margin-right: ${toString theme.padding}px;
    }

    #image.nixos {
      /* Fuckass image is 2 pixels too tall if we don't add extra padding to either side */
      padding: ${toString (theme.padding / 2 + 1)}px;
      border-radius: 1000rem;
      background-color: ${theme.colors.base};
      border: ${toString theme.border-width}px solid ${theme.colors.contrast-primary};
    }

    #cpu, #load, #memory, #temperature,
    #custom-notifications, #clock, #battery, #wireplumber, #backlight, #keyboard-state, #mpris, #tray {
      padding: 0 ${toString theme.padding}px;
      margin-top: ${toString (theme.padding / 2)}px;
      margin-bottom: ${toString (theme.padding / 2)}px;
      border-radius: 1000rem;
      background-image: linear-gradient(${theme.gradient-angle}, ${theme.colors.contrast-primary}, ${theme.colors.contrast-secondary});
    }

    #battery.warning {
      background-color: ${theme.colors.warn};
      background-image: none;
    }

    #battery.critical {
      background-color: ${theme.colors.error};
      background-image: none;
    }

    #battery.charged {
      background-color: ${theme.colors.okay};
      background-image: none;
    }

    #keyboard-state .capslock {
      margin-right: ${toString theme.padding}px;
    }

    #custom-notifications {
      padding: 0 ${toString (builtins.floor (theme.padding * 1.25))}px;

    }

    #workspaces {
      padding: 0;
      margin-top: ${toString (theme.padding / 2)}px;
      margin-bottom: ${toString (theme.padding / 2)}px;
      border-radius: 1000rem;
      background-image: linear-gradient(${theme.gradient-angle}, ${theme.colors.contrast-primary}, ${theme.colors.contrast-secondary});
    }

    #workspaces button {
      box-shadow: none;
      text-shadow: none;
      padding: 0;
      border-radius: 1000rem;
      background: transparent;

      margin: ${toString (theme.padding / 2)}px;
      padding-left: 0;
      padding-right: 0;

      transition: all ${theme.css-transition-duration} ${theme.css-transition-curve};
    }

    #workspaces button.active {
      background: ${theme.colors.base};
      padding-left: ${toString (builtins.floor (theme.padding * 3 / 4))}px;
      padding-right: ${toString (builtins.floor (theme.padding * 3 / 4))}px;
    }

    #workspaces button.active,
    #workspaces button.active * {
      color: ${theme.colors.text};
    }

    #workspaces button.urgent {
      background: ${theme.colors.red};
      padding-left: ${toString (builtins.floor (theme.padding * 3 / 4))}px;
      padding-right: ${toString (builtins.floor (theme.padding * 3 / 4))}px;
    }
    '';
  };
}
