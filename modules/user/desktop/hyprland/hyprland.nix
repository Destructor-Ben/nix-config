{ pkgs, theme, ... }:
let
  template-theme-values = path: path;
in 
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

  home.file.".config/hypr/hyprland.lua".source = template-theme-values ../../../../dotfiles/hyprland/hyprland.lua;
  home.file.".config/hypr/config/input.lua".source = template-theme-values ../../../../dotfiles/hyprland/config/input.lua;
  home.file.".config/hypr/config/monitors.lua".source = template-theme-values ../../../../dotfiles/hyprland/config/monitors.lua;

  wayland.windowManager.hyprland = {
    #enable = true;

    # Use hyprland and XDG portal from the NixOS module
    #package = null;
    #portalPackage = null;

    #xwayland.enable = true;
    # TODO: should i include? systemd.enable = false; # Conflicts with the system module
    # TODO: if i do, then also enable UWSM because it replaces the systemd stuff

    # TODO: use lxappearance/stylix to theme apps
    # TODO: setup file picker
    # TODO: fix window decorations
    # TODO: get cava
    # TODO: make a audio player visualizer that is only visible on empty workspaces


    # settings = {

    #   exec-once =
    #   [
    #     "audio-listen"
    #   ];

    # };
  };

  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;

      preload = [
        (toString theme.wallpaper)
      ];

      wallpaper = [
        {
          monitor = "eDP-1";
          path = toString theme.wallpaper;
        }
        {
          monitor = "HDMI-A-1";
          path = toString theme.wallpaper;
        }
      ];
    };
  };

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;
  services.hyprpolkitagent.enable = true;
  services.cliphist.enable = true;
  services.wl-clip-persist.enable = true;
  services.poweralertd.enable = true; # TODO: configure + make sure this works
}
