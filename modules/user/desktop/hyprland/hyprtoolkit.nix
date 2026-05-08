{ theme, ... }:
{
  home.file.".config/hypr/hyprtoolkit.conf".text = ''
    background = ${theme.colors.base}
    base = ${theme.colors.surface-0}
    alternate_base = ${theme.colors.surface-1}
    text = ${theme.colors.text}
    bright_text = ${theme.colors.base}
    accent = ${theme.colors.contrast-primary}
    accent_secondary = ${theme.colors.contrast-secondary}

    h1_size = ${toString (builtins.floor (theme.font-size * 2.5))}
    h2_size = ${toString (builtins.floor (theme.font-size * 2))}
    h3_size = ${toString (builtins.floor (theme.font-size * 1.5))}
    font_size = ${toString (theme.font-size)}
    small_font_size = ${toString (theme.font-size / 2)}

    icon_theme = ${theme.icon-theme}
    font_family = ${theme.fonts.ui}
    font_family_monospace = ${theme.fonts.code}

    rounding_large = ${toString (theme.border-radius)}
    rounding_small = ${toString (theme.border-radius / 2)}
  '';
}
