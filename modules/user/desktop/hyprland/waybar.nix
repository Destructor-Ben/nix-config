{ pkgs, theme, ... }:
{
  home.packages = with pkgs; [
    waybar-mpris
  ];

  programs.waybar = rec {
    enable = true;

    settings = {
      main = {
        layer = "bottom";
        position = "top";
        height = 32;

        modules-left = [
          "image#nixos"
          # TODO: add
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          # TODO: system stats
          "keyboard-state"
          # TODO: figure out what these are
          "idle_inhibitor"
          "tray"
          "mpris"
          # TODO: bluetooth
          "wireplumber"
          "battery"
          "clock"
          # TOOD: notifications
        ];

        "image#nixos" = {
          path = "/home/ben/nix-config/img/Nix.svg";
          size = 24;
          # TODO: onclick
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

    style = ''
    window#waybar {
      background-color: transparent;
      border: none;
      padding: ${toString ((settings.main.height - settings.main."image#nixos".size) / 2)}px;
    }
    '';
  };
}
