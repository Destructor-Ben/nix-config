{ config, theme, ... }:
{
  systemd.tmpfiles.rules = [
    "L /var/lib/AccountsService/icons/ben - - - - ${theme.pfp}"
  ];
}
