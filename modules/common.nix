{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.extraOptions = ''
    warn-dirty = false
  '';

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import ../overlays/plymouth)
      (import ../overlays/wlogout)
    ];
  };
}
