{ pkgs, ...}:
{
  home.packages = with pkgs; [
    hyprpicker
    grimblast
    kooha
  ];

  # TODO: allow remapping scancodes -> keycodes for custom keyboard layout so I can swap ctrl and left alt
  wayland.windowManager.hyprland.settings = {
    gesture = "3, horizontal, workspace"; # TODO: make this have a smaller threshold to start

    input = {
      sensitivity = 0.1;
      numlock_by_default = false;
      # Piecewise mouse accel
      accel_profile = let
        cutoff-point = 2; # The point where linear acceleration is disabled
        multiplier = 2; # Mouse accel multiplier after the above cutoff
      in
        "custom ${toString cutoff-point} 0.0 ${toString cutoff-point} ${toString (cutoff-point * 2 * multiplier)} "; 

      touchpad = {
        disable_while_typing = false;
        natural_scroll = true;
        scroll_factor = 0.8;
        clickfinger_behavior = true;
      };
    };

    # TODO: make sure bindl (lock screen) and binde (can be held) work properly
    "$mod" = "Alt_L"; #"SUPER"; # TODO: temporary until i fix my windows key
    bind =
    [
      "$mod, C, killactive,"
      "$mod, Q, forcekillactive,"
      "$mod, J, workspace, -1"
      "$mod, K, workspace, +1"
      # TODO: fullscreen kb
      # TODO: toggle floating
      # TODO: pin floating windows
      # TODO: resizing + moving floating windows:
      #bindm = $mainMod, mouse:272, movewindow
      #bindm = $mainMod, mouse:273, resizewindow

      "$mod, SPACE, exec, wofi --show drun"
      "$mod, Return, exec, kitty"
      "$mod, F, exec, dolphin"
      "$mod, B, exec, zen"

      # TODO: do this for all hotkeys to stop duplicate processes being run for stuff where only 1 thing should run
      "$mod, V, exec, pgrep hyprpicker || hyprpicker" # TODO: configure + make it copy
      "$mod, S, exec, grimblast --notify --freeze copysave area"
      "$mod SHIFT, S, exec, kooha"
      ", code:248, exec, grimblast --notify --cursor copysave screen" # F12 key on laptop

      ",XF86MonBrightnessUp,   exec, brightnessctl set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"

      # TODO: also make popup for audio indicators
      # TODO: also play a sound when audio changes
      # TODO: round volume to nearest 5%
      # TODO: auto mute when volume goes to 0 and unmute when volume is changed?
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute,     exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      # TODO: see if pausing/playing audio suddenly stops audio, and if it does, see if I can make it fade in/out
      ",XF86AudioPlay, exec, playerctl play-pause"
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioPrev, exec, playerctl previous"
      ",XF86AudioStop, exec, playerctl stop"
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
