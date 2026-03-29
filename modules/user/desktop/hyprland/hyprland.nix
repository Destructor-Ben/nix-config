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

  # TODO: set a system + monospace font
  # TODO: set a system light/dark mode
  # TODO: setup cava

  /*
  TODO: see if i want these packages:
  Possible packages:
    hyprsysteminfo                                        # Displays information about the running system
    wofi-emoji                                            # Wofi emoji picker
    hyprpicker                                            # Colour picker
  */

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
    # TODO: get cava

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
        "col.active_border" = "${theme.colors.contrast-primary} ${theme.colors.contrast-secondary} ${theme.gradient-angle}";
      };

      decoration = {
        rounding = theme.border-radius;
        # TODO: decide on squircle or circle: rounding_power = 4;
        # TODO: implement my own cool effects: screen_shader = "path/to/shader.frag";
      };
    };
  };

  # TODO: configure below

  programs.hyprlock = {
    enable = true;
  };

  services.swaync = {
    enable = true;
  };
  # END TODO

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
