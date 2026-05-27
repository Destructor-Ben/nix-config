{ pkgs, unstable, theme, ...}:
{
  home.packages = with pkgs; [
    unstable.hyprshutdown
  ];

  # TODO: logging in and out doesn't properly close processes started via exec-once in hyprland
  # - using systemd user services might be a good idea to fix this instead of exec-once
  # - do the above (helps for security), but it isn't the entire solution

  # TODO: make the screen brightness fade in and out when darkening, and also make it fade in and out when suspending + unsuspending
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "playerctl pause && loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # Monitor backlight
        {
          timeout = 180;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }

        # Keyboard backlight
        { 
          timeout = 180;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }

        # Suspend
        {
          timeout = 210;
          on-timeout = "loginctl lock-session && systemctl suspend";
        }
      ];
    };
  };

  # TODO: adjust positions + shadows
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
      };

      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };

      background = {
        path = "screenshot";
        blur_passes = 3;
      };

      label = [
        {
          text = "cmd[update:60000] date +\"%A, %d %B\"";
          font_size = 24;
          font_family = theme.fonts.impact;
          color = theme.colors.text;

          position = "0, -70";
          halign = "center";
          valign = "top";
          shadow_passes = 1;
          shadow_boost = 1;
        }
        {
          text = "cmd[update:1000] date +\"%-I:%M %p\"";
          font_size = 72;
          font_family = theme.fonts.impact;
          color = theme.colors.text;

          # No idea where the 3 comes from, it just looks like it matches
          position = "0, -${toString (70 + 24 + 3)}";
          halign = "center";
          valign = "top";
          shadow_passes = 1;
          shadow_boost = 1;
        }
      ];

      input-field = {
        size = "400, ${toString (theme.font-size * 4)}";
        position = "0, 0";
        halign = "center";
        valign = "center";

        outline_thickness = theme.border-width;
        inner_color = theme.colors.surface-0;
        outer_color = "${theme.colors.contrast-primary} ${theme.colors.contrast-secondary} ${theme.hyprlock-gradient-angle}";
        check_color = "${theme.colors.warn} ${theme.colors.warn-alt} ${theme.hyprlock-gradient-angle}";
        fail_color = "${theme.colors.error} ${theme.colors.error-alt} ${theme.hyprlock-gradient-angle}";

        font_color = theme.colors.text;
        rounding = theme.font-size * 2;
        fade_on_empty = false;
        shadow_passes = 1;
        shadow_boost = 1;

        font_family = theme.fonts.ui;
        placeholder_text = "Enter password";
        fail_text = "$PAMFAIL";
        dots_spacing = "0.3";
      };
    };
  };

  # TODO: the power button + waybar are broken (waybar has broken onclick events bceause it doesn't reference wlogout-custom properly, power button doesn't have icons)
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "sleep 0.75 && loginctl lock-session";
      }
      {
        label = "logout";
        action = "hyprshutdown -t 'Logging out...'";
      }
      {
        label = "suspend";
        action = "sleep 0.75 && loginctl lock-session && systemctl suspend";
      }
      {
        label = "reboot";
        action = "hyprshutdown --post-cmd 'systemctl reboot' -t 'Rebooting...'";
      }
      {
        label = "shutdown";
        action = "hyprshutdown --post-cmd 'systemctl poweroff' -t 'Shutting down...'";
      }
    ];

    style = let
      wlogout-icons = ../../../../img/wlogout;
    in ''
      * {
        background-image: none;
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
        border-width: ${toString (theme.border-width * 3 / 2)}px;
        border-radius: 100%;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 75%;
        box-shadow: ${theme.shadows.md};
      }

      button:focus, button:active, button:hover {
        background-color: ${theme.colors.surface-1};
        outline-style: none;
      }

      #lock {
        background-image: image(url("${wlogout-icons}/system-lock-screen.svg"));
      }

      #logout {
        background-image: image(url("${wlogout-icons}/system-log-out.svg"));
      }

      #suspend {
        background-image: image(url("${wlogout-icons}/system-suspend.svg"));
      }

      #shutdown {
        background-image: image(url("${wlogout-icons}/system-shutdown.svg"));
      }

      #reboot {
        background-image: image(url("${wlogout-icons}/system-reboot.svg"));
      }
    '';
  };
}
