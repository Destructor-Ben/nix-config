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
    discord
    prismlauncher
    mesa-demos

    # Creative
    gimp
    inkscape
    blender
  ];
}