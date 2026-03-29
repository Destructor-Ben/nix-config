{
  wallpaper = "/home/ben/nix-config/img/Wallpaper.png";

  gradient-angle = "45deg";
  padding = 10;
  border-width = 4;
  border-radius = 10;

  fonts = {
    code = "'JetBrainsMono Nerd Font'";
    ui = "'JetBrainsMono Nerd Font Propo'";
  };

  # Catpuccin Mocha
  # https://catppuccin.com/palette/
  colors = rec {
    rosewater = "rgb(245,224,220)";
    flamingo = "rgb(242,205,205)";
    pink = "rgb(245,194,231)";
    mauve = "rgb(203,166,247)";
    red = "rgb(243,139,168)";
    maroon = "rgb(235,160,172)";
    peach = "rgb(250,179,135)";
    yellow = "rgb(249,226,175)";
    green = "rgb(166,227,161)";
    teal = "rgb(148,226,213)";
    sky = "rgb(137,220,235)";
    sapphire = "rgb(116,199,236)";
    blue = "rgb(137,180,250)";
    lavender = "rgb(180,190,254)";

    text = "rgb(205,214,244)";
    subtext-1 = "rgb(186,194,222)";
    subtext-0 = "rgb(166,173,200)";

    overlay-2 = "rgb(147,153,178)";
    overlay-1 = "rgb(127,132,156)";
    overlay-0 = "rgb(108,112,134)";

    surface-2 = "rgb(88,91,112)";
    surface-1 = "rgb(69,71,90)";
    surface-0 = "rgb(49,50,68)";

    base = "rgb(30,30,46)";
    mantle = "rgb(24,24,37)";
    crust = "rgb(17,17,27)";

    terminal-pink = "38;2;245;194;231";
    terminal-mauve = "38;2;203;166;247";

    contrast-primary = mauve;
    contrast-secondary = pink;

    okay = green;
    warn = yellow;
    error = red;
  };
}
