{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Programming
    jetbrains.rider
    jetbrains.idea-ultimate
    godot-mono
    avalonia-ilspy
    nixd
    nixfmt

    # Core utils1
    nemo-with-extensions # TODO: fix the rubbish, also finish configuring
    vlc # TODO: rename in the .desktop file to captialize "media player"
    loupe
    # TODO: something to handle zip files

    # Misc utils
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