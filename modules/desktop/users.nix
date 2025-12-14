{
  users.users.ben = {
    isNormalUser = true;
    description = "Ben";
    extraGroups = [ "networkmanager" "wheel" ];
    # TODO: move the packages away
    packages = with pkgs; [
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
  };
}
