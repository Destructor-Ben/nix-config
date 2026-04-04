{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Programming
    vscode
    jetbrains.rider
    jetbrains.idea-ultimate
    godot-mono
    avalonia-ilspy

    # Utility
    spotify
    obsidian
    prismlauncher
    mesa-demos
    libreoffice-qt

    # Creative
    gimp
    inkscape
    aseprite
    blender
    lmms

    # Fun
    figlet
    cowsay
    cmatrix
    lolcat
  ];
}