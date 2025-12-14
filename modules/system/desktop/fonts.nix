{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];
}
