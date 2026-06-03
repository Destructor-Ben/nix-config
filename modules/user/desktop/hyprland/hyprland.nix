{ pkgs, theme, ... }:
{
  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  # TODO: setup cava

  wayland.windowManager.hyprland = {
    enable = true;

    # Use hyprland and XDG portal from the NixOS module
    package = null;
    portalPackage = null;

    xwayland.enable = true;
    # TODO: should i include? systemd.enable = false; # Conflicts with the system module
    # TODO: if i do, then also enable UWSM because it replaces the systemd stuff

    # TODO: use lxappearance/stylix to theme apps
    # TODO: setup file picker
    # TODO: fix window decorations
    # TODO: get cava
    # TODO: make a audio player visualizer that is only visible on empty workspaces

    settings = {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
        "HDMI-A-1,1920x1080@143.85Hz,0x-1080,1"
      ];

      exec-once =
      [
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
        "HDMI-A-1,${toString theme.wallpaper}"
      ];
    };
  };

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;
  services.hyprpolkitagent.enable = true;
  services.cliphist.enable = true;
  services.wl-clip-persist.enable = true;
}
