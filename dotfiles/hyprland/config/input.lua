local mouse_accel_cuttof = 20 -- The point where linear acceleration is disabled
local mouse_accel_multiplier = 2 -- Mouse accel multiplier after the above cutoff

hl.config({
  input = {
    kb_layout = "mao",
    numlock_by_default = false,
    sensitivity = 0.1,

    -- Piecewise mouse accel
    --accel_profile = "custom " .. mouse_accel_cuttof .. " 0.0 " .. mouse_accel_cuttof .. mouse_accel_cuttof * 2 * mouse_accel_multiplier;

    touchpad = {
      disable_while_typing = false,
      natural_scroll = true,
      scroll_factor = 0.8,
      clickfinger_behavior = true,
    },
  },
})

-- TODO: gestures have been redone
  -- #   gesture = "3, horizontal, workspace"; # TODO: make the threshold and speed of this lesser


local mod = "ALT" -- TODO: in future, change to ALT_L when i figure out how to make it work -- TODO: temporary, change to SUPER when windows key gets fixed

hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.kill())

  -- #           "$mod, code:1${toString i}, workspace, ${toString ws}"
  -- #           "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"

-- TODO: make these use scrolling + ALT in the future
-- #     "$mod, J, workspace, -1"
-- #     "$mod, K, workspace, +1"
-- #     "$mod SHIFT, J, movetoworkspace, -1"
-- #     "$mod SHIFT, K, movetoworkspace, +1"

-- #     "$mod SHIFT, F, fullscreen, 1, toggle"
-- #     "$mod, F, togglefloating"
-- #     "$mod, P, pin"

  -- #     "$mod, L, exec, loginctl lock-session"
  -- #     ", XF86PowerOff, exec, wlogout-custom"
  -- #   bind = [

  -- #     "$mod, Space, exec, pidof wofi || wofi -p \"Search apps and projects\" --show drun"
  -- #     "$mod, Period, exec, pidof wofi || wofi-emoji"
  -- #     # TODO: fix the trailing newline
  -- #     "$mod, V, exec, pidof wofi || cliphist list | wofi -p \"Search clipboard\" --dmenu --pre-display-cmd \"echo '%s' | cut -f 2\" | cliphist decode | wl-copy"
      
hl.bind(mod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("nemo"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("zen"))

hl.bind(mod .. " + C", hl.dsp.exec_cmd("pidof hyprpicker || hyprpicker --format=hex -l -a"))
hl.bind(mod .. " + S", hl.dsp.exec_cmd("pidof grimblast || grimblast --notify --freeze copysave area"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("pidof kooha || kooha"))
hl.bind(mod .. " + code:248", hl.dsp.exec_cmd("pidof grimblast || grimblast --notify --cursor copysave screen")) -- F12 key on laptop
