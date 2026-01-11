{ pkgs, ... }:
let
  sddmTheme = pkgs.callPackage ../../../pkgs/sddm-theme.nix {};
in
{
  environment.systemPackages = [ sddmTheme ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "destructor-ben";
    extraPackages = [ sddmTheme ];
  };

  services.desktopManager.plasma6.enable = true;

  # X11 required for SDDM
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "nz";
    variant = "";
  };
}
