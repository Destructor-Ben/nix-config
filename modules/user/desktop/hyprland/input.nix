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

    # TODO: make sure bindl (lock screen) and binde (can be held) work properly
    "$mod" = "SUPER";
    bind =
    [
      "$mod, C, killactive,"
      "$mod, Q, forcekillactive,"

      # TODO: also setup hypridle to automatically sleep computer
      # TODO: locking "$mod, L, forcekillactive,"
      # TODO: make the power button open a menu instead: ", xf86poweroff, exec, TODO"
      # "SUPER, Escape, exec, pidof swaylock || swaylock"
      # "SUPER SHIFT, Escape, exec, my-sleep"
      # "SUPER SHIFT CTRL, Escape, exec, hyprshutdown -t 'Shutting down...' --post-cmd 'my-shutdown'"
      # "SUPER SHIFT CTRL ALT, Escape, exec, hyprshutdown -t 'Restarting...' --post-cmd 'reboot'"
      # ", switch:Lid Switch, exec, my-sleep"

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
      #  - TODO: write a wireplumber lua plugin to trigger the correct scripts to enable/disable the LEDs
        # The mute LEDs were a pain in the ass to figure out how to get working but thank this person
        # https://bugzilla.kernel.org/show_bug.cgi?id=216197
      # TODO: round volume to nearest 5%
      ", xf86audioraisevolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
      ", xf86audiolowervolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
      ", xf86audiomute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", xf86audiomicmute,     exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      # TODO: get brightnessctl and playerctl
      #",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      #",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      # ",XF86AudioPlay,exec, playerctl play-pause"
      # ",XF86AudioNext,exec, playerctl next"
      # ",XF86AudioPrev,exec, playerctl previous"
      # ",XF86AudioStop, exec, playerctl stop"

      # TODO: make sure closing the lid sleeps the laptop and locks it
      # bindl = , switch:on:Lid Switch, exec, hyprctl dispatch dpms off
      # bindl = , switch:off:Lid Switch, exec, hyprctl dispatch dpms on

      "$mod, J, workspace, -1"
      "$mod, K, workspace, +1"
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
