{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Programming
    vscode
    helix
    jetbrains.rider
    jetbrains.idea-ultimate
    godot-mono
    avalonia-ilspy

    # Utility
    spotify
    obsidian
    discord
    prismlauncher

    # Creative
    gimp
    inkscape
    blender

    # Fun stuff
    fastfetch
    figlet
    cowsay
    mesa-demos
  ];
}