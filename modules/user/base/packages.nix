{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch
    figlet
    cowsay
  ];
}