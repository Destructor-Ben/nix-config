{ theme, ... }:
{
  # TODO: configure
  # TODO: send notifications on critical + warning battery + charging notif
  # TODO: unblock all notifications
  services.swaync = {
    enable = true;

    settings = {
      control-center-margin-top = theme.padding;
      control-center-margin-bottom = theme.padding;
      control-center-margin-right = theme.padding;
    };

    style = ''

    '';
  };
}
