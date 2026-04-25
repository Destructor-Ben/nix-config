{ pkgs, custom-fonts, ... }:
{
  boot.plymouth = {
    enable = true;
    theme = "spinfinity";
    font = "${custom-fonts}/share/fonts/truetype/Red-Seven.otf";
    logo = ../../../img/Nix-Boot.png;
  };

  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
