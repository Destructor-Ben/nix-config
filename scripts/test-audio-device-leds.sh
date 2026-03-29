# required pulseaudio to be installed: nix-shell -p pulseaudio

sudo echo "Need sudo now to avoid asking later"

pactl subscribe | while read -r line; do
    if echo "$line" | grep -q "sink"; then
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"; then
            echo "Muted"
            sudo hda-verb /dev/snd/hwC1D0 0x20 0x500 0x0b && sudo hda-verb /dev/snd/hwC1D0 0x20 0x400 0x08
        else
            echo "Unmuted"
            sudo hda-verb /dev/snd/hwC1D0 0x20 0x500 0x0b && sudo hda-verb /dev/snd/hwC1D0 0x20 0x400 0x00
        fi
    fi

    if echo "$line" | grep -q "source"; then
        if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"; then
            echo "Muted mic"
            sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_MASK 0x16 && sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DIR 0x16 && sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x00
        else
            echo "Unmuted mic"
            sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x04
        fi
    fi
done
