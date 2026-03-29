{
  programs.zsh.shellAliases.cd = "z";

  programs.zoxide = {
    enable = true;                                                         
    enableZshIntegration = true;                                           
  };

  programs.fzf = {
    enable = true;                                                         
    enableZshIntegration = true;                                           
  };
}
