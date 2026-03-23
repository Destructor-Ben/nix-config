{
  wallpaper = "/home/ben/nix-config/img/Wallpaper.png";

  padding = 10;
  border-width = 4;
  border-radius = 10;
  gradient-angle = "45deg";

  # Catpuccin Mocha
  # https://catppuccin.com/palette/
  # TODO: make these have different forms, eg. hex, rgb, rgba, hsl, etc.
  colors = rec {
    pink = "rgb(245,194,231)";
    mauve = "rgb(203,166,247)";

    base = "rgb(30,30,46)";
    mantle = "rgb(24,24,37)";
    crust = "rgb(17,17,27)";

    contrast-1 = mauve;
    contrast-2 = pink;
  };
}
