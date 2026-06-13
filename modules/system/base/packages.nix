{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget curl
    git gh
    zip unzip p7zip
    btop iotop
    tree file which jq
    bat
    killall
    wineWow64Packages.stable
    helix
    gnumake
  ];
}
