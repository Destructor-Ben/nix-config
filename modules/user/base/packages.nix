{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch # TODO: configure fastfetch
    figlet
    cowsay
  ];
}