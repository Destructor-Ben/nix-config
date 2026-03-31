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
