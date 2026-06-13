require("config.input")
require("config.monitors")
require("config.window-rules")

hl.on("hyprland.start", function () 
  hl.exec_cmd("audio-listen")
end)

hl.config({
  general = {
    border_size = #theme.border-width#,
    gaps_in = #theme.padding# / 2,
    gaps_out = #theme.padding#,
    col = {
      inactive_border = "#theme.colors.surface-0#",
      active_border = {
        colors = {
          "#theme.colors.contrast-primary#",
          "#theme.colors.contrast-secondary#",
        },
        angle = #theme.gradient-angle-number#,
      },
    },
  },
  decoration = {
    rounding = #theme.border-radius#,
    -- TODO: shadows
  },
  -- TODO: animations
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },
})
