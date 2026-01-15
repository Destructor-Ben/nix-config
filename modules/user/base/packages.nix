{ pkgs, ... }:
{
  home.packages = with pkgs; [
    helix
    fastfetch
    figlet
    cowsay
  ];
}