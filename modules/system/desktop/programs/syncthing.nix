{
  # TODO: configure all folders and devices from here
  # TODO: shouldn't this be in base?
  services.syncthing = {
    enable = true;
    user = "ben";
    group = "users";
    dataDir = "/home/ben";
    configDir = "/home/ben/.config/syncthing";
    openDefaultPorts = true;
  };
}
