{ pkgs, unstable, ...}:
{
  home.packages = with pkgs; [
    unstable.hyprshutdown # TODO: link this to the power button, also show a power menu
  ];

  # HYPRLAND BINDS:
      # TODO: also setup hypridle to automatically sleep computer
      # TODO: locking "$mod, L, forcekillactive,"
      # TODO: make the power button open a menu instead: ", xf86poweroff, exec, TODO"
      # "SUPER, Escape, exec, pidof swaylock || swaylock"
      # "SUPER SHIFT, Escape, exec, my-sleep"
      # "SUPER SHIFT CTRL, Escape, exec, hyprshutdown -t 'Shutting down...' --post-cmd 'my-shutdown'"
      # "SUPER SHIFT CTRL ALT, Escape, exec, hyprshutdown -t 'Restarting...' --post-cmd 'reboot'"
      # ", switch:Lid Switch, exec, my-sleep"
      # TODO: make sure closing the lid sleeps the laptop and locks it
      # bindl = , switch:on:Lid Switch, exec, hyprctl dispatch dpms off
      # bindl = , switch:off:Lid Switch, exec, hyprctl dispatch dpms on
}
