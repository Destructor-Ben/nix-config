{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/base
    ../../modules/system/desktop
  ];

  system.stateVersion = "25.05";
  networking.hostName = "bens-laptop";

  # Dual boot windows compat, which stores local time instead of UTC
  time.hardwareClockInLocalTime = true;
}
