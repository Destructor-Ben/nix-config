{ pkgs, theme, ... }:
{
  home.packages = with pkgs; [
    waybar-mpris
  ];

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
          "mpris"
          "tray"
          # TODO: bluetooth
          # TODO: wifi
          # TODO: upower? - use for bluetooth headphones
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
          # TODO: mic muted: 󰍭
          format = "{icon} {volume}%";
          format-muted = " {volume}%";
          format-icons = [ "" "" "" ];
          tooltip = false;
        };
        battery = {
          states = {
            warning = 25;
            critical = 10;
          };
          format = "{icon} {capacity}%";
          format-charging = "󱐋{icon} {capacity}%";
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

    # TODO: style layout indicators
    # TODO: remove all tooltips except for the the systen tray?
    # TODO: add shadows?
    style =
    ''
    * {
      font-family: "${theme.fonts.ui}";
      font-size: 12px;
      color: ${theme.colors.crust};

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

    .modules-left, .modules-right {
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
      padding: ${toString (theme.padding / 2)}px;
      border-radius: 1000rem;
      background-color: ${theme.colors.crust};
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
    '';
  };
}
