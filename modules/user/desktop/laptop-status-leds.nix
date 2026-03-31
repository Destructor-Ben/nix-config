{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (writeShellScriptBin "update-speaker-led" ''
      if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"; then
        sudo hda-verb /dev/snd/hwC1D0 0x20 0x500 0x0b && sudo hda-verb /dev/snd/hwC1D0 0x20 0x400 0x08
      else
        sudo hda-verb /dev/snd/hwC1D0 0x20 0x500 0x0b && sudo hda-verb /dev/snd/hwC1D0 0x20 0x400 0x00
      fi
    '')

    (writeShellScriptBin "update-mic-led" ''
      if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"; then
        sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_MASK 0x16 && sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DIR 0x16 && sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x00
      else
        sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x04
      fi
    '')
  ];
}