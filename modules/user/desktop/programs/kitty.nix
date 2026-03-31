{ theme, ... }:
{
  programs.kitty = {
    enable = true;

    enableGitIntegration = true;
    shellIntegration.enableZshIntegration = true;

    themeFile = "Catppuccin-Mocha";
    font = {
      name = theme.fonts.code;
      size = 11;
    };

    settings = {
      window_padding_width = theme.padding;
      scrollback_lines = 10000;
      enable_audio_bell = false;
    };
  };
}
