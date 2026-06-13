{ pkgs, lib, theme, ... }:
let
  # Template theme values into the lua files
  template-theme-values = path:
    let
      contents = builtins.readFile path;
      tokens = builtins.split "#theme\\.([a-zA-Z0-9_\\.-]+)#" contents;
      getAttrPath = pathStr: let
        parts = builtins.filter builtins.isString (builtins.split "\\." pathStr);
      in
        lib.attrsets.getAttrFromPath parts theme;

      processedTokens = map (token:
        if builtins.isList token then
          toString (getAttrPath (builtins.head token))
        else
          token
      ) tokens;
    in
      builtins.concatStringsSep "" processedTokens;
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

  home.file.".config/hypr/hyprland.lua".text = template-theme-values ../../../../dotfiles/hyprland/hyprland.lua;
  home.file.".config/hypr/config/input.lua".text = template-theme-values ../../../../dotfiles/hyprland/config/input.lua;
  home.file.".config/hypr/config/monitors.lua".text = template-theme-values ../../../../dotfiles/hyprland/config/monitors.lua;
  home.file.".config/hypr/config/window-rules.lua".text = template-theme-values ../../../../dotfiles/hyprland/config/window-rules.lua;

  # TODO: use lxappearance/stylix to theme apps
  # TODO: style file picker
  # TODO: get cava
  # TODO: make a audio player visualizer that is only visible on empty workspaces

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
