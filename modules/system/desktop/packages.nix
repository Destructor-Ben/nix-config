{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wev
    brightnessctl
    playerctl
    wl-clipboard

    catppuccin-cursors.mochaDark # SDDM will need this too
  ];

  # Random fix for wlogout icons
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
}
