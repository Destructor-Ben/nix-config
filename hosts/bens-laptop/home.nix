{ config, pkgs, ... }:
{
  imports = [
    ../../modules/user
  ]

  home.stateVersion = "25.05";

  home.username = "ben";
  home.homeDirectory = "/home/ben";
}
