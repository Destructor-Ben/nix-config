{
  programs.wofi = {
    enable = true;

    # TODO: stop weird anim when starting up
    # TODO: make case insensitive
    # TODO: if no options present, DONT OPEN GEOMETRY DASH YOU STUPID FUCK
    # TODO: don't allow running abritrary commands
    settings = {
      # TODO: idk if these are right
      # actually fuck you wofi i hate you
      close_on_focus_loss = true;
      insensitive = true;
      matching = "fuzzy";
      no_custom_entry = true;
    };

/* TODO: configure
    settings = {

    };

    style =
    ''
    '';*/
  };
}
