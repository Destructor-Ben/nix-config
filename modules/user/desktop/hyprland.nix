{ pkgs, ... }:
{
  # TODO: split this into multiple files
  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland

    # TODO: install unstable.hyprshutdown # TODO: link this to the power button, also show a power menu
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # Use hyprland and XDG portal from the NixOS module
    package = null;
    portalPackage = null;

    # TODO: test xwayland: xwayland.enable = true;
    # TODO: home.sessionVariables.NIXOS_OZONE_WL = "1";
    # TODO: use lxappearance to theme apps
    # TODO: setup cursor theme
    # TODO: setup file picker
    # TODO:   QT_QPA_PLATFORM = "wayland;xcb";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # TODO: fix window decorations
    # TODO: setup input profiles

    settings = {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
      ];

      # TODO: finish configuring
      input = {
        sensitivity = 0.25;

        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
          scroll_factor = 0.8;
          clickfinger_behavior = true;
        };
      };

      exec-once =
      [
        "waybar"
      ];

      "$mod" = "SUPER";
      bind =
      [
        # TODO: lock
        "$mod, C, killactive,"
        "$mod, Q, forcekillactive,"
        "$mod, SPACE, exec, rofi -show drun"
        "$mod, Return, exec, kitty"

        "$mod, J, workspace, -1"
        "$mod, K, workspace, +1"

        # TODO: is this screenshotting? ", Print, exec, grimblast copy area"
      ] ++ (
        # Workspaces - binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
    };
  };

  # TODO: configure below

  programs.waybar = {
    enable = true;

    settings = {
      main = {
        layer = "bottom";
        position = "top";
        height = 30;

        modules-right =
        [
          "clock"
        ];
      };
    };
  };

  programs.rofi = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
  };

  services.swaync = {
    enable = true;
  };
}
