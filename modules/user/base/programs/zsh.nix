{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {                                                          
      enable = true;                                                       
      plugins = [ "git" "gh" "fzf" ];                                           
    };

    shellAliases = {
      ngc = "ns && sudo nix-collect-garbage -d && nix-collect-garbage -d && ns";
    };

    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      source ~/.utils.zsh
    '';
  };

  home.file.".p10k.zsh".source = ../../../../dotfiles/.p10k.zsh;
  home.file.".utils.zsh".source = ../../../../dotfiles/.utils.zsh;

  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];
}
