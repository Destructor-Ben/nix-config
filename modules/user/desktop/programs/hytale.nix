{ pkgs, hytale-launcher, ... }:
{
  home.packages = [
    hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
