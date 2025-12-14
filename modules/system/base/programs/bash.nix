{
  # Symlink bash into /bin/bash so external programs don't cry about it
  systemd.tmpfiles.rules = [
    "L+ /bin/bash - - - - /run/current-system/sw/bin/bash"
  ];
}
