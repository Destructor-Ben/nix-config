{
  # TODO: customize the theme to be catppuccin
  programs.btop = {
    enable = true;
    # TODO: make settings set via nix?
  };

  home.file.".config/btop/btop.conf".source = ../../../../dotfiles/btop.conf;
}
