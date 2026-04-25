{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Programming
    vscode # TODO: remove
    vscodium-fhs
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
    audacity

    # Fun
    figlet
    cowsay
    cmatrix
    lolcat
  ];
}