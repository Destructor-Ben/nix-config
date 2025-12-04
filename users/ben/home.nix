{ config, pkgs, ... }:
{
  home.stateVersion = "25.05";

  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.packages = with pkgs; [
    fastfetch
  ];
}
