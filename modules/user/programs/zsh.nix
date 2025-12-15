{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ns = "sudo nixos-rebuild switch --flake ~/nix-config";
      ngc = "ns && sudo nix-collect-garbage -d && ns";
    };
  };
}
