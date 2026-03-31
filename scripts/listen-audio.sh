#!/usr/bin/env bash

# Based on: https://github.com/ilyamiro/nixos-configuration/blob/master/config/sessions/hyprland/scripts/volume_listener.sh

# Helper functions to get current state
get_sink() { pactl get-default-sink; }
get_vol() { wpctl get-volume @DEFAULT_AUDIO_SINK@; }

# 1. Initialize state
last_sink=$(get_sink)
last_vol=$(get_vol)

# 2. Loop through events
# Unfortunately, pactl is needed since no other subscription behaviour properly exists for pipewire
# This is a pulseaudio compat layer provided from pipewire
pactl subscribe | grep --line-buffered "Event 'change' on sink" | while read -r line; do
    
    current_sink=$(get_sink)
    current_vol=$(get_vol)

    # CHECK 1: Did the Output Device change? (e.g. Headphones connected)
    if [[ "$current_sink" != "$last_sink" ]]; then
        # The device changed. We do NOT want a popup for this.
        # Just update our tracking variables to the new device's levels.
        last_sink="$current_sink"
        last_vol="$current_vol"
        continue
    fi

    # CHECK 2: Did the Volume actually change on the SAME device?
    if [[ "$current_vol" != "$last_vol" ]]; then
        
        # Trigger OSD (without changing volume)
        #swayosd-client --output-volume 0

        # Update status LEDs
        update-speaker-led
        # TODO: mic LED

        # Update tracking
        last_vol="$current_vol"
    fi
done
