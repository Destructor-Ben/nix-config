# required pulseaudio to be installed: nix-shell -p pulseaudio

sudo echo "Need sudo now to avoid asking later"

pactl subscribe | while read -r line; do
    if echo "$line" | grep -q "sink"; then
        update-speaker-led
    fi

    if echo "$line" | grep -q "source"; then
        update-mic-led
    fi
done
