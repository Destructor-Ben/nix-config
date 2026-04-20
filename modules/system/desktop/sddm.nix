{ pkgs, sddm-theme, theme, ... }:
{
  environment.systemPackages = [ sddm-theme ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = false;
    theme = "catppuccin-mocha-mauve"; # TODO: better pkg name
    # TODO: see if this is needed: extraPackages = [ sddm-theme ];

    settings = {
      Theme = {
        CursorTheme = theme.cursor.name;
        CursorSize = theme.cursor.size;
      };
    };
  };
}
