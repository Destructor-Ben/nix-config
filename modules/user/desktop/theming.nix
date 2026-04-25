{ pkgs, ... }:
{
  # TODO: properly organise themeing stuff
  home.packages = with pkgs; [
    papirus-icon-theme
  ];
}