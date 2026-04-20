{ theme, ... }:
{
  home.file.".face.icon" = {
    source = theme.pfp;
    recursive = false;
  };
}
