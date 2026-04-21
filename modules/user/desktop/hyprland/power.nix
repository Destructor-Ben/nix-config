{ pkgs, unstable, ...}:
{
  home.packages = with pkgs; [
    unstable.hyprshutdown
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      ", xf86poweroff, exec, wlogout"
    ];
  };

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "playerctl pause && loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      # TODO: setup listeners, use the ones on the hypridle example
    };
  };

  programs.hyprlock = {
    enable = true;

    # TODO settings = {};
  };

  programs.wlogout = {
    enable = true;

    # TODO: test all of these
    layout = [
      {
        "label" = "lock";
        "action" = "loginctl lock-session";
        "text" = "Lock";
      }
      {
        "label" = "hibernate";
        "action" = "loginctl lock-session && systemctl hibernate";
        "text" = "Hibernate";
      }
      {
        "label" = "logout";
        "action" = "hyprshutdown";
        "text" = "Logout";
      }
      {
        "label" = "shutdown";
        "action" = "hyprshutdown --post-cmd 'systemctl poweroff'";
        "text" = "Shutdown";
      }
      {
        "label" = "suspend";
        "action" = "loginctl lock-session && systemctl suspend";
        "text" = "Suspend";
      }
      {
        "label" = "reboot";
        "action" = "hyprshutdown --post-cmd 'systemctl reboot'";
        "text" = "Reboot";
      }
    ];

    # TODO: style properly
    style = ''
      * {
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: rgba(30, 30, 46, 0.90);
      }

      button {
        border-radius: 0;
        border-color: #cba6f7;
        text-decoration-color: #cdd6f4;
        color: #cdd6f4;
        background-color: #181825;
        border-style: solid;
        border-width: 1px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        /* 20% Overlay 2, 80% mantle */
        background-color: rgb(48, 50, 66);
        outline-style: none;
      }
    '';
  };
}
