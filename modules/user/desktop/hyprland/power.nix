{ pkgs, unstable, theme, ...}:
{
  home.packages = with pkgs; [
    unstable.hyprshutdown
  ];

  # TODO: configure hyprshutdown

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        # Kill wlogout to avoid the fading out anim that gets stuck
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

    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
      }
      {
        label = "logout";
        action = "~/nix-config/scripts/hyprshutdown-custom.sh";
      }
      {
        label = "suspend";
        action = "loginctl lock-session && systemctl suspend";
      }
      {
        label = "shutdown";
        action = "~/nix-config/scripts/hyprshutdown-custom.sh --post-cmd 'systemctl poweroff'";
      }
      {
        label = "reboot";
        action = "~/nix-config/scripts/hyprshutdown-custom.sh --post-cmd 'systemctl reboot'";
      }
    ];

    # TODO: proper icons
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
        background-size: 50%;
        box-shadow: ${theme.css-shadow};
      }

      button:focus, button:active, button:hover {
        background-color: ${theme.colors.surface-1};
        outline-style: none;
      }

      #lock {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }

      #logout {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }

      #suspend {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }

      #shutdown {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}
