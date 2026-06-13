{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Hyprland utils
    hyprpicker
    grimblast
    kooha
    wofi-emoji

    # Programming
    jetbrains.rider
    jetbrains.idea
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
    pinta
    aseprite
    gimp
    inkscape
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