{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscodium
  ];
  # TODO: enable when updated
  # programs.vscodium = {
  #   enable = true;
  #   enableUpdateCheck = false;
  #   userSettings = ../../../../dotfiles/vscodium/settings.json;

  #   extensions = with pkgs.vscode-extensions; [

  #   ];
  # };
}
