{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ns = "sudo nixos-rebuild switch --flake ~/nix-config"; # TODO: add a git add . to it too
      ngc = "ns && sudo nix-collect-garbage -d && ns";
      nd = "nix develop --command zsh";
      # TODO: nix develop ~/nix-config#$1
    };

    initContent = ''
      # Powerlevel10k theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Load your p10k config (if it exists)
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  home.file.".p10k.zsh".source = ../../../dotfiles/.p10k.zsh;

  home.packages = with pkgs; [
    zsh-powerlevel10k
    meslo-lgs-nf
  ];
}
