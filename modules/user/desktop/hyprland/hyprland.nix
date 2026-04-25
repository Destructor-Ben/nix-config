{ pkgs, theme, ... }:
{
  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # TODO: set a system + monospace font
  # TODO: set a system light/dark mode
  # TODO: setup cava
  # TODO: run browser when hyprland starts on workspace 1

  /*
  TODO: see if i want these packages:
  Possible packages:
    hyprsysteminfo                                        # Displays information about the running system
    wofi-emoji                                            # Wofi emoji picker
  */

  wayland.windowManager.hyprland = {
    enable = true;

    # Use hyprland and XDG portal from the NixOS module
    package = null;
    portalPackage = null;

    xwayland.enable = true;

    # TODO: use lxappearance to theme apps
    # TODO: setup cursor theme
    # TODO: set icon theme
    # TODO: setup file picker
    # TODO: setup clipboard
    # TODO:   QT_QPA_PLATFORM = "wayland;xcb";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # TODO: fix window decorations
    # TODO: get cava

    settings = {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
      ];

      exec-once =
      [
        "waybar"
        "audio-listen"
      ];

      general = {
        border_size = theme.border-width;
        gaps_in = theme.padding / 2;
        gaps_out = theme.padding;
        "col.inactive_border" = theme.colors.surface-0;
        "col.active_border" = "${theme.colors.contrast-primary} ${theme.colors.contrast-secondary} ${theme.gradient-angle}";

        # TODO: temp
        resize_on_border = true;
      };

      decoration = {
        rounding = theme.border-radius;
        # TODO: decide on squircle or circle: rounding_power = 4;
        # TODO: implement my own cool effects: screen_shader = "path/to/shader.frag";
      };

      misc = {
        disable_hyprland_logo = true;
      };
    };
  };

  # TODO: configure
  # TODO: send notifications on critical + warning battery + charging notif
  # TODO: unblock all notifications
  services.swaync = {
    enable = true;
  };

  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;

      preload = [
        (toString theme.wallpaper)
      ];

      wallpaper = [
        "eDP-1,${toString theme.wallpaper}"
      ];
    };
  };

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;
  services.hyprpolkitagent.enable = true;
}
