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

        #  1 padding for against screen, another to give each pill some padding
        height = theme.status-bar-height + theme.padding * 2 + theme.border-width * 2;

        modules-left = [
          "image#nixos" # TODO: make clicking on this open a terminal running fastfetch
          # TODO: configure fastfetch
          # TODO: add system stats here
          "cpu"
          "load"
          "temperature#z0"
          "temperature#z1"
          "memory"
          "network"
          "disk"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "idle_inhibitor" # TODO: figure out what this is
          "keyboard-state"
          "tray"
          "mpris"
          # TODO: bluetooth
          "wireplumber"
          "battery"
          "clock"
          # TODO: notifications
        ];

        "image#nixos" = {
          path = "/home/ben/nix-config/img/Nix.svg";
          size = theme.status-bar-height;
          on-click = "kitty --hold fastfetch";
        };
        
        # TODO: add a bunch of apps

        keyboard-state = {
          "numlock" = true;
          "capslock" = true;
          "format" = "{name} {icon}";
          "format-icons" = {
            "locked" = "";
            "unlocked" = "";
          };
        };
      };
    };

    # TODO: style layout indicators
    # TODO: style tooltips
    style =
    ''
    * {
      font-family: ${theme.font};
      font-size: ${toString theme.status-bar-font-size}px;
      color: ${theme.colors.text};

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
      padding: 2px;
      border-radius: 1000rem;
      background-color: ${theme.colors.crust};
      border: ${toString theme.border-width}px solid ${theme.colors.contrast-primary};
    }

    #cpu, #load, #temperature, #memory, #network, #disk, #clock, #battery, #wireplumber, #mpris, #tray, #keyboard-state, #idle_inhibitor {
      padding: ${toString (theme.padding / 2)}px ${toString theme.padding}px;
      border-radius: 1000rem;
      background-image: linear-gradient(${theme.gradient-angle}, ${theme.colors.contrast-primary}, ${theme.colors.contrast-secondary});
      color: ${theme.colors.crust};
    }
    '';
  };
}
