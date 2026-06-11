{ pkgs, ...}:
{
  home.packages = with pkgs; [
    hyprpicker
    grimblast
    kooha
    wofi-emoji
  ];

  # TODO: allow remapping scancodes -> keycodes for custom keyboard layout so I can swap ctrl and left alt
  wayland.windowManager.hyprland.settings = {
    gesture = "3, horizontal, workspace"; # TODO: make the threshold and speed of this lesser

    input = {
      kb_layout = "mao";
      numlock_by_default = false;

      sensitivity = 0.1;
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
      "$mod, Q, killactive,"
      "$mod SHIFT, Q, forcekillactive,"
      "$mod, J, workspace, -1"
      "$mod, K, workspace, +1"
      "$mod SHIFT, J, movetoworkspace, -1"
      "$mod SHIFT, K, movetoworkspace, +1"
      # TODO: fullscreen keybind
      # TODO: toggle floating
      # TODO: pin floating windows
      # TODO: resizing + moving floating windows:
      #bindm = $mainMod, mouse:272, movewindow
      #bindm = $mainMod, mouse:273, resizewindow

      "$mod, L, exec, loginctl lock-session"
      ", XF86PowerOff, exec, wlogout-custom"
      ", switch:on:Lid Switch, exec, loginctl lock-session && systemctl suspend"
      ", switch:off:Lid Switch, exec, hyprctl dispatch dpms on"

      "$mod, Space, exec, pidof wofi || wofi -p \"Search apps and projects\" --show drun"
      "$mod, Period, exec, pidof wofi || wofi-emoji"
      # TODO: fix the trailing newline
      "$mod, V, exec, pidof wofi || cliphist list | wofi -p \"Search clipboard\" --dmenu --pre-display-cmd \"echo '%s' | cut -f 2\" | cliphist decode | wl-copy"
      "$mod, Return, exec, kitty"
      "$mod, F, exec, nemo"
      "$mod, B, exec, zen"

      "$mod, C, exec, pidof hyprpicker || hyprpicker --format=hex -l -a"
      "$mod, S, exec, pidof grimblast || grimblast --notify --freeze copysave area"
      "$mod SHIFT, S, exec, pidof kooha || kooha"
      ", code:248, exec, pidof grimblast || grimblast --notify --cursor copysave screen" # F12 key on laptop

      # TODO: fix rounding errors
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
      # Workspaces
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
