{ pkgs, sddm-theme, theme, ... }:
{
  environment.systemPackages = [ sddm-theme.packages.${pkgs.stdenv.hostPlatform.system}.personal ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    wayland.compositor = "weston";
    autoNumlock = false;
    theme = "catppuccin-rounded";

    extraPackages = with pkgs; [
      kdePackages.qtbase
      kdePackages.qtsvg
      kdePackages.qt5compat
    ];

    settings = {
      Theme = {
        CursorTheme = theme.cursor.name;
        CursorSize = theme.cursor.size;
      };
    };
  };
}
