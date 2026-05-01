{ pkgs, unstable, theme, ...}:
{
  home.packages = with pkgs; [
    unstable.hyprshutdown
  ];

  # TODO: configure hyprshutdown
  # TODO: logging in and out doesn't properly close processes started via exec-once in hyprland
  # - using systemd user services might be a good idea to fix this instead of exec-once

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        # Kill wlogout to avoid the fading out anim that gets stuck
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "playerctl pause && loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # Monitor backlight
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }

        # Keyboard backlight
        { 
          timeout = 150;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }

        # Suspend
        {
          timeout = 180;
          on-timeout = "loginctl lock-session && systemctl suspend";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;

    # TODO settings = {};
  };

  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
      }
      {
        label = "logout";
        action = "hyprshutdown-custom";
      }
      {
        label = "suspend";
        action = "loginctl lock-session && systemctl suspend";
      }
      {
        label = "shutdown";
        action = "hyprshutdown-custom --post-cmd 'systemctl poweroff'";
      }
      {
        label = "reboot";
        action = "hyprshutdown-custom --post-cmd 'systemctl reboot'";
      }
    ];

    style = ''
      * {
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: ${theme.colors.base-transparent};
      }

      button {
        border-radius: 0;
        border-color: ${theme.colors.contrast-primary};
        text-decoration-color: ${theme.colors.text};
        color: ${theme.colors.text};
        background-color: ${theme.colors.surface-0};
        border-style: solid;
        border-width: ${toString theme.border-width}px;
        border-radius: 100%;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 75%;
        box-shadow: ${theme.css-shadow};
      }

      button:focus, button:active, button:hover {
        background-color: ${theme.colors.surface-1};
        outline-style: none;
      }

      #lock {
        background-image: image(url("${../../../../img/wlogout/system-lock-screen.svg}"));
      }

      #logout {
        background-image: image(url("${../../../../img/wlogout/system-log-out.svg}"));
      }

      #suspend {
        background-image: image(url("${../../../../img/wlogout/system-suspend.svg}"));
      }

      #shutdown {
        background-image: image(url("${../../../../img/wlogout/system-shutdown.svg}"));
      }

      #reboot {
        background-image: image(url("${../../../../img/wlogout/system-reboot.svg}"));
      }
    '';
  };
}
