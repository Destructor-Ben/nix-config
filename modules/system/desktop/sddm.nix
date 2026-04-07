{ pkgs, sddm-theme, theme, ... }:
{
  environment.systemPackages = [ sddm-theme ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = false;
    #theme = "destructor-ben"; TODO: renable and remake
    extraPackages = [ sddm-theme ];

    settings = {
      Theme = {
        CursorTheme = theme.cursor.name;
        CursorSize = theme.cursor.size;
      };
    };
  };
}
