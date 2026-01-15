{ config, ... }:
{
  systemd.tmpfiles.rules = [
    "L /var/lib/AccountsService/icons/ben - - - - /home/ben/.face.icon"
  ];
}
