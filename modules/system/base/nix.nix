{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.extraOptions = ''
    warn-dirty = false
  '';
}
