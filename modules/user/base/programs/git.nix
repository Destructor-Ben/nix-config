{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "Destructor-Ben";
        email = "destructor.ben@gmail.com";
      };

      init.defaultBranch = "main";

      core = {
        editor = "code";
        pager = "less"; # TODO: use a better pager in the future/configure less so it doesn't fucking suck
      };
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      editor = "code";
      browser = "zen";
    };
  };
}
