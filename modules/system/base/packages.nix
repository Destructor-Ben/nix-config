{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget curl
    git gh
    zip unzip p7zip
    btop iotop
    tree file which jq
    wineWowPackages.stable
    helix
    gnumake
  ];
}
