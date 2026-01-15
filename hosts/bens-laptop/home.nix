{ config, pkgs, ... }:
{
  imports = [
    ../../modules/user/base
    ../../modules/user/desktop
  ];

  home.stateVersion = "25.05";

  home.username = "ben";
  home.homeDirectory = "/home/ben";
}
