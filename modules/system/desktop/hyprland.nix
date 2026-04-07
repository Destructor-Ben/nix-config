{
  # Add hyprland cache
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.hyprland.enable = true;
  services.gnome.gnome-keyring.enable = true;

   # TODO: nuke plasma very soon
  services.desktopManager.plasma6.enable = true;
}
