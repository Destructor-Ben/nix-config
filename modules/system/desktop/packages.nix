{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wev
    alsa-tools
    brightnessctl
    playerctl
  ];
}
