{ pkgs, custom-fonts, ... }:
{
  fonts.packages = with pkgs; [
    custom-fonts
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];
}
