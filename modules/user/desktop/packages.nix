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
    nemo # TODO: add other non-plamsa alternatives, also im pretty sure i need to configure nemo
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