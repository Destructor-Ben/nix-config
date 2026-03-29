{ pkgs, ... }:
{
  home.packages = with pkgs; [
    figlet
    cowsay
  ];
}