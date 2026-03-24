{
  # TODO: allow remapping scancodes -> keycodes for custom keyboard layout so I can swap ctrl and left alt
  wayland.windowManager.hyprland.settings = {
    # TODO: tweak, perhaps change mouse acceleration curves
    input = {
      sensitivity = 0.1;
      numlock_by_default = true;

      touchpad = {
        disable_while_typing = false;
        natural_scroll = true;
        scroll_factor = 0.8;
        clickfinger_behavior = true;
      };
    };

    "$mod" = "SUPER";
    bind =
    [
      "$mod, C, killactive,"
      "$mod, Q, forcekillactive,"
      # TODO: locking "$mod, L, forcekillactive,"
      # TODO: intercept power button

      "$mod, J, workspace, -1"
      "$mod, K, workspace, +1"

      "$mod, SPACE, exec, rofi -show drun"
      "$mod, Return, exec, kitty"
      "$mod, D, exec, dolphin"
      "$mod, B, exec, zen"
      ", code:248, exec, code" # F12 key on laptop
      # TODO: give the above a real use case

      "$mod, S, exec, grimblast save area" # TODO: make it copy area in the future
      # TODO: color picker: "$mod, P, exec, TODO" # TODO: make it copy area in the future

      # TODO: also make popup for audio indicators + test sound
      # TODO: fix LEDs on mute audio + mute mic buttons
      ", xf86audioraisevolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
      ", xf86audiolowervolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
      ", xf86audiomute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", xf86audiomicmute,     exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ] ++ (
      # Workspaces - binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
    );
  };
}
