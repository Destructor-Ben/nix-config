{ pkgs, theme, ... }:
{
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = theme.cursor.name;
    size = theme.cursor.size;

    # TODO: autogenerate configs
  };
}
