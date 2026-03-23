{ pkgs, unstable, theme, ... }:
{
  # TODO: split this into more files
  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland

    grimblast
    unstable.hyprshutdown # TODO: link this to the power button, also show a power menu
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;

    # Use hyprland and XDG portal from the NixOS module
    package = null;
    portalPackage = null;

    xwayland.enable = true;

    # TODO: use lxappearance to theme apps
    # TODO: setup cursor theme
    # TODO: setup file picker
    # TODO: setup clipboard
    # TODO:   QT_QPA_PLATFORM = "wayland;xcb";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # TODO: fix window decorations

    settings = {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
      ];

      exec-once =
      [
        "systemctl --user start hyprpolkitagent"
        "systemctl --user start hyprpaper"
        "waybar"
      ];

      general = {
        border_size = theme.border-width;
        gaps_in = theme.padding / 2;
        gaps_out = theme.padding;
        "col.inactive_border" = theme.colors.crust;
        "col.active_border" = "${theme.colors.contrast-1} ${theme.colors.contrast-2} ${theme.gradient-angle}";
      };

      decoration = {
        rounding = theme.border-radius;
        # TODO: decide on squircle or circle: rounding_power = 4;
        # TODO: implement my own cool effects: screen_shader = "path/to/shader.frag";
      };

      # TODO: make this a module
      # TODO: finish configuring
      # TODO: improve the mouse acceleration curves
      input = {
        sensitivity = 0.1;
        numlock_by_default = true;

        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
          scroll_factor = 0.8;
          clickfinger_behavior = true;
        };
      };

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

        "$mod, S, exec, grimblast save area" # TODO: make it copy area in the future
        # TODO: allow muting audio + mic to work, also the mic button should get support added
        # TODO: also make popup for audio indicators
        # TODO: stop the volume going above 100
        ", xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
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

  # WOFI instead of ROFI, since ROFI uses xorg?
  programs.rofi = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };

  services.swaync = {
    enable = true;
  };

  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;

      preload = [theme.wallpaper];

      wallpaper = [
        "eDP-1,${theme.wallpaper}"
      ];
    };
  };

  services.network-manager-applet.enable = true;
  services.hyprpolkitagent.enable = true;
}
