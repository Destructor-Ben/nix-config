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
          "temperature#z0"
          "temperature#z1"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "mpris"
          "tray"
          "keyboard-state"
          # TODO: bluetooth
          # TODO: wifi
          # TODO: battery
          "wireplumber"
          "battery"
          "clock"
          # TODO: notifications
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
          format = "  {percentage}% ({used}/{total} GiB)";
          tooltip = false;
        };
        "temperature#z0" = {
          thermal-zone = 0;
          format-icons = ["" "" "" "" ""];
          format = "{icon} {temperatureC}°C (Z0)";
          tooltip = false;
        };
        "temperature#z1" = {
          thermal-zone = 1;
          format-icons = ["" "" "" "" ""];
          format = "{icon} {temperatureC}°C (Z1)";
          tooltip = false;
        };

        keyboard-state = {
          "numlock" = true;
          "capslock" = true;
          "format" = "{name} {icon}";
          "format-icons" = {
            "locked" = "";
            "unlocked" = "";
          };
        };
        clock = {
          format = "{:%a %d %b %I:%M %p}";
          tooltip = false;
        };
      };
    };

    # TODO: style layout indicators
    # TODO: style tooltips
    style =
    ''
    * {
      font-family: ${theme.font};
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

    #cpu, #load, #temperature, #memory, #network, #disk, #clock, #battery, #wireplumber, #mpris, #tray, #keyboard-state, #idle_inhibitor {
      padding: 0 ${toString theme.padding}px;
      margin-top: ${toString (theme.padding / 2)}px;
      margin-bottom: ${toString (theme.padding / 2)}px;
      border-radius: 1000rem;
      background-image: linear-gradient(${theme.gradient-angle}, ${theme.colors.contrast-primary}, ${theme.colors.contrast-secondary});
    }
    '';
  };
}
