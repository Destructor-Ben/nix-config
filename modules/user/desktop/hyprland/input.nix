{ pkgs, ...}:
{
  home.packages = with pkgs; [
    hyprpicker
    grimblast
    kooha
    wofi-emoji
  ];

  # TODO: allow remapping scancodes -> keycodes for custom keyboard layout so I can swap ctrl and left alt
  # wayland.windowManager.hyprland.settings = {

  #   "$mod" = "Alt_L"; #"SUPER"; # TODO: temporary until i fix my windows key

  #   bindm = [
  #     "$mod, mouse:272, movewindow"
  #     "$mod, mouse:273, resizewindow"
  #   ];

  #   bindl = [
  #     # TODO: fix rounding errors
  #     ", XF86MonBrightnessUp,   exec, brightnessctl set 5%+"
  #     ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

  #     # TODO: also make popup for audio indicators
  #     # TODO: also play a sound when audio changes
  #     # TODO: round volume to nearest 5%
  #     # TODO: auto mute when volume goes to 0 and unmute when volume is changed?
  #     ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
  #     ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
  #     ", XF86AudioMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
  #     ", XF86AudioMicMute,     exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

  #     # TODO: see if pausing/playing audio suddenly stops audio, and if it does, see if I can make it fade in/out
  #     ", XF86AudioPlay, exec, playerctl play-pause"
  #     ", XF86AudioNext, exec, playerctl next"
  #     ", XF86AudioPrev, exec, playerctl previous"
  #     ", XF86AudioStop, exec, playerctl stop"

  #     ", switch:on:Lid Switch, exec, loginctl lock-session && systemctl suspend"
  #     ", switch:off:Lid Switch, exec, hyprctl dispatch dpms on"
  #   ];

  # };
}
