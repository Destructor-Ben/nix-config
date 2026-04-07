{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wev
    brightnessctl
    playerctl

    catppuccin-cursors.mochaDark # SDDM will needs this too

    # Both of these are for the laptop LEDs
    alsa-tools
    pulseaudio
  ];
}
