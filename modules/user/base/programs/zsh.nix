{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ngc = "ns && sudo nix-collect-garbage -d && ns";
    };

    initContent = ''
      # Powerlevel10k theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Load your p10k config (if it exists)
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # Load custom zsh utils
      source ~/.utils.zsh
    '';
  };

  home.file.".p10k.zsh".source = ../../../../dotfiles/.p10k.zsh;
  home.file.".utils.zsh".source = ../../../../dotfiles/.utils.zsh;

  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];
}
