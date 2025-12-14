{
  # TODO: configure all folders and devices from here
  services.syncthing = {
    enable = true;
    user = "ben";
    group = "users";
    dataDir = "/home/ben";
    configDir = "/home/ben/.config/syncthing";
    openDefaultPorts = true;
  };
}
