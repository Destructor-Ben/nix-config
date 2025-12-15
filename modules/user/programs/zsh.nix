{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ns = "sudo nixos-rebuild switch";
      ngc = "sudo nixos-rebuild switch && sudo nix-collect-garbage -d && sudo nixos-rebuild switch";
    };
  };
}
