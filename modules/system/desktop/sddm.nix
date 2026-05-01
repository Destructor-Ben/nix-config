{ pkgs, sddm-theme, theme, ... }:
{
  environment.systemPackages = [ sddm-theme.packages.${pkgs.stdenv.hostPlatform.system}.default ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    wayland.compositor = "weston";
    autoNumlock = false;
    theme = "catppuccin-mocha-mauve"; # TODO: update theme name when i finally do

    settings = {
      Theme = {
        CursorTheme = theme.cursor.name;
        CursorSize = theme.cursor.size;
      };
    };
  };
}
