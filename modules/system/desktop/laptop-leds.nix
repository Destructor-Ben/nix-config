{ pkgs, ... }:
{
  # Based on https://bugzilla.kernel.org/show_bug.cgi?id=216197
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "update-speaker-led" ''
      if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"; then
        hda-verb-bin /dev/snd/hwC1D0 0x20 0x500 0x0b && hda-verb-bin /dev/snd/hwC1D0 0x20 0x400 0x08
      else
        hda-verb-bin /dev/snd/hwC1D0 0x20 0x500 0x0b && hda-verb-bin /dev/snd/hwC1D0 0x20 0x400 0x00
      fi
    '')

    (writeShellScriptBin "update-mic-led" ''
      if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"; then
        hda-verb-bin /dev/snd/hwC1D0 0x01 SET_GPIO_MASK 0x16 && hda-verb-bin /dev/snd/hwC1D0 0x01 SET_GPIO_DIR 0x16 && hda-verb-bin /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x00
      else
        hda-verb-bin /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x04
      fi
    '')
  ];

  # Fuck you security you only make my life harder
  # Give hda-verb perms to run without sudo
  security.wrappers.hda-verb-bin = {
    owner = "root";
    group = "root";
    source = "${pkgs.alsa-tools}/bin/hda-verb";
    setuid = true;
  };
}
