{ pkgs, sddm-theme, ... }:
{
  environment.systemPackages = [ sddm-theme ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    #theme = "destructor-ben"; TODO: renable
    extraPackages = [ sddm-theme ];
  };
}
