{
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # X11 required for SDDM
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "nz";
    variant = "";
  };
}
