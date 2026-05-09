{ pkgs, custom-fonts, ... }:
{
  # TODO: finish themeing

  # TODO: set a system + monospace font
  # TODO: set a system light/dark mode
  # TODO: set the system theme

  environment.systemPackages = with pkgs; [
    papirus-icon-theme
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      custom-fonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

  # TODO: force mono font for all apps?
  /* TODO: fix
  stylix = {
    enable = true;

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = pkgs.noto-fonts;
        name = "JetBrainsMono Nerd Font";
      };

      # TODO: use apple emojis
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  # TODO: temp
  home-manager.users.ben = {
    # This is the "Nuclear" option for when modules are broken
    # It removes the problematic configuration from the evaluation entirely
    #options.qt.qt5ctSettings = lib.mkAliasDefinitions options.qt.platformTheme; 
    
    # Alternatively, try this simpler override:
    stylix.targets.qt.enable = lib.mkForce false;
  };*/
}
