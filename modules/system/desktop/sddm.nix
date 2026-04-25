{ pkgs, sddm-theme, theme, ... }:
{
  environment.systemPackages = [ sddm-theme ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    wayland.compositor = "weston"; # TODO: check if this is needed once I remove plasma, fuck you kwin for making my cursor get larger
    autoNumlock = false;
    theme = "catppuccin-mocha-mauve"; # TODO: better pkg name

    settings = {
      Theme = {
        CursorTheme = theme.cursor.name;
        CursorSize = theme.cursor.size;
      };
    };
  };
}
