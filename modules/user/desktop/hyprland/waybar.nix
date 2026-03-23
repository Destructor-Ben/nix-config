{ pkgs, theme, ... }:
{
  programs.waybar = {
    enable = true;

    settings = {
      top = {
        layer = "bottom";
        position = "top";
        height = 32;

        modules-left = [
          "hyprland/workspaces"
          # TODO: add app launchers here, as well as a nixos icon
        ];
        modules-center = [
          # TODO: have workspace indicators here in the middle
        ];
        modules-right = [
          "keyboard-state"
          # TODO: figure out what these are
          "mpris"
          "wireplumber"
          "tray"
          "idle_inhibitor"
          "backlight"
          "battery"
          "clock"
        ];

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
  };
}
