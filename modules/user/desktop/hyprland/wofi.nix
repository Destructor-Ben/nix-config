{ theme, ... }:
{
  # TODO: fix this
  wayland.windowManager.hyprland.settings.layerrule = "animation fade, match:namespace wofi";

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
      gtk_dark = true;
    };

    # TODO: try to add drop shadow
    # TODO: finish
    style = ''
      #window {
        background-color: transparent;
      }
      
      #outer-box {
        background-color: ${theme.colors.base};
        border: ${toString theme.border-width}px solid ${theme.colors.contrast-primary};
        border-radius: ${toString (theme.border-radius * 2)}px;
        padding: ${toString theme.padding}px;
      }

      #input, #scroll {
        background-color: ${theme.colors.base};
        border: ${toString (theme.border-width / 2)}px solid ${theme.colors.surface-1};
        border-radius: ${toString theme.border-radius}px;
        padding: ${toString (theme.padding / 2)}px;
      }

      #input {
        color: ${theme.colors.text};
      }

      #scroll {
        padding-top: 0;
        margin-top: ${toString theme.padding}px;
      }

      /* TODO: make entries border based? */
      #entry {
        background-color: ${theme.colors.surface-0};
        background-image: none;

        border-radius: ${toString (theme.border-radius / 2)}px;
        padding: ${toString (theme.padding / 2)}px;
        margin-top: ${toString (theme.padding / 2)}px;
      }

      #entry:active, #entry:hover {
        background-color: ${theme.colors.surface-1};
        background-image: none;
      }

      #entry:selected {
        background-color: transparent;
        background-image: linear-gradient(${theme.gradient-angle}, ${theme.colors.contrast-primary}, ${theme.colors.contrast-secondary});
      }

      #text {
        color: ${theme.colors.subtext-1};
      }

      #text:selected {
        color: ${theme.colors.base};
      }

      #input, #text {
        font-size: ${toString theme.font-size-md}px;
        font-family: ${theme.fonts.ui};
      }
    '';
  };
}
