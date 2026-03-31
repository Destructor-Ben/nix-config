{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wev
    alsa-tools
    pulseaudio # Required for laptop LEDs
    brightnessctl
    playerctl
  ];
}
