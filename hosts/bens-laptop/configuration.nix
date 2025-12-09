{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base
    ../../modules/desktop
  ];

  system.stateVersion = "25.05";
  networking.hostName = "bens-laptop";

  # TODO: old, everything below must be cleaned up

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "nz";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable bluetooth
  services.blueman.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ben = {
    isNormalUser = true;
    description = "Ben";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Programming
      vscode
      helix
      jetbrains.rider
      jetbrains.idea-ultimate
      godot-mono
      avalonia-ilspy

      # Utility
      spotify
      obsidian
      discord
      prismlauncher

      # Creative
      gimp
      inkscape
      blender

      # Fun stuff
      fastfetch
      figlet
      cowsay
      mesa-demos
    ];
  };

  # Install firefox
  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Symlink bash into /bin/bash so external programs don't cry about it
  #programs.bash.enable = true;
  #systemd.tmpfiles.rules = [
  #  "L+ /bin/bash - - - - /run/current-system/sw/bin/bash"
  #  "L+ /bin/sh   - - - - /run/current-system/sw/bin/bash"
  #];

  # Setup Syncthing
  services.syncthing = {
    enable = true;
    user = "ben";
    group = "users";
    dataDir = "/home/ben";
    configDir = "/home/ben/.config/syncthing";
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
  };
}
