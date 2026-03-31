{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wev
    brightnessctl
    playerctl

    # Both of these are for the laptop LEDs
    alsa-tools
    pulseaudio
  ];
}
