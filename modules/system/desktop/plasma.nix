{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ sddm-astronaut ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut";
    extraPackages = [ pkgs.sddm-astronaut ];
  };

  services.desktopManager.plasma6.enable = true;

  # X11 required for SDDM
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "nz";
    variant = "";
  };
}
