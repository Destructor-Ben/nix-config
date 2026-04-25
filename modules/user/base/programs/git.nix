{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "Destructor-Ben";
        email = "destructorben208@gmail.com";
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
