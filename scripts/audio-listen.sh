#!/usr/bin/env bash

# Based on: https://github.com/ilyamiro/nixos-configuration/blob/master/config/sessions/hyprland/scripts/volume_listener.sh

get_sink() { pactl get-default-sink; }
get_source() { pactl get-default-source; }
get_vol() { wpctl get-volume @DEFAULT_AUDIO_SINK@; }
get_src_vol() { wpctl get-volume @DEFAULT_AUDIO_SOURCE@; }

last_sink=$(get_sink)
last_source=$(get_source)
last_vol=$(get_vol)
last_src_vol=$(get_src_vol)

# Unfortunately, pactl is needed since no other subscription behaviour properly exists for pipewire
# This is a pulseaudio compat layer provided from pipewire
pactl subscribe | grep --line-buffered -E "Event 'change' on (sink|source)" | while read -r _; do
    
    current_sink=$(get_sink)
    current_source=$(get_source)
    current_vol=$(get_vol)
    current_src_vol=$(get_src_vol)

    # No device changes the Volume actually change on the SAME device?
    # TODO: update in the future
    # if [[ "$current_sink" == "$last_sink" ]] && [[ "$current_vol" != "$last_vol" ]]; then
        
    #     # Trigger OSD (without changing volume)
    #     # TODO: renable: swayosd-client --output-volume 0
    # fi

    # If either device or volume changes then update the respective leds
    if [[ "$current_sink" != "$last_sink" ]] || [[ "$current_vol" != "$last_vol" ]]; then
        update-speaker-led
    fi
    if [[ "$current_source" != "$last_source" ]] || [[ "$current_src_vol" != "$last_src_vol" ]]; then
        update-mic-led
    fi

    last_sink="$current_sink"
    last_source="$current_source"
    last_vol="$current_vol"
    last_src_vol="$current_src_vol"
done
