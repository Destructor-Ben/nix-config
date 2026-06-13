local mouse_accel_cuttof = 20 -- The point where linear acceleration is disabled
local mouse_accel_multiplier = 2 -- Mouse accel multiplier after the above cutoff

-- TODO: allow remapping scancodes -> keycodes for custom keyboard layout so I can swap ctrl and left alt

hl.config({
  input = {
    kb_layout = "mao",
    numlock_by_default = false,
    sensitivity = 0.1,

    -- Piecewise mouse accel
    -- TODO: fix in the future
    --accel_profile = "custom " .. mouse_accel_cuttof .. " 0.0 " .. mouse_accel_cuttof .. mouse_accel_cuttof * 2 * mouse_accel_multiplier;

    touchpad = {
      disable_while_typing = false,
      natural_scroll = true,
      scroll_factor = 0.8,
      clickfinger_behavior = true,
    },
  },
})

-- TODO: make the threshold and speed of this lesser
hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

local mod = "ALT" -- TODO: in future, change to ALT_L when i figure out how to make it work -- TODO: temporary, change to SUPER when windows key gets fixed

for i = 1,10 do
  local key = i % 10 -- 0 key maps to workspace 10
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + K", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mod .. " + J",   hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mod .. " + SHIFT + J",   hl.dsp.window.move({ workspace = "r-1" }))

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mod .. " + SHIFT + mouse_up",   hl.dsp.window.move({ workspace = "r-1" }))

hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.kill())

hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
hl.bind(mod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pin())

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("wlogout-custom"))
-- TODO: test these 2
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("loginctl lock-session && systemctl suspend"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms on"), { locked = true })

hl.bind(mod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("nemo"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("zen"))

hl.bind(mod .. " + C", hl.dsp.exec_cmd("pidof hyprpicker || hyprpicker --format=hex -l -a"))
hl.bind(mod .. " + S", hl.dsp.exec_cmd("pidof grimblast || grimblast --notify --freeze copysave area"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("pidof kooha || kooha"))
hl.bind("code:248", hl.dsp.exec_cmd("pidof grimblast || grimblast --notify --cursor copysave screen")) -- F12 key on laptop

hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("pidof wofi || wofi -p \"Search apps and projects\" --show drun"))
hl.bind(mod .. " + PERIOD", hl.dsp.exec_cmd("pidof wofi || wofi-emoji"))
-- TODO: fix the trailing newline
hl.bind(mod .. " + V", hl.dsp.exec_cmd("pidof wofi || cliphist list | wofi -p \"Search clipboard\" --dmenu --pre-display-cmd \"echo '%s' | cut -f 2\" | cliphist decode | wl-copy"))

-- TODO: fix rounding errors
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true })

-- TODO: fix rounding errors
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
-- TODO: also make popup for audio indicators
-- TODO: also play a sound when audio changes
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

-- see if pausing/playing audio suddenly stops audio, and if it does, see if I can make it fade in/out
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
