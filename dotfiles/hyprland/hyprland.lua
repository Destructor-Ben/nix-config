require("config.input")
require("config.monitors")

hl.config({
  -- general = {
  --   border_size = #theme.border-width#,
  --   gaps_in = #theme.padding# / 2,
  --   gaps_out = #theme.padding#,
  --   col = {
  --     inactive_border = #theme.colors.surface-0#,
  --     active_border = #"${theme.colors.contrast-primary} ${theme.colors.contrast-secondary} ${theme.gradient-angle}"#,
  --   },
  -- },
  -- decoration = {
  --   rounding = #theme.border-radius#,
  --   -- TODO: shadows
  -- },
  -- TODO: animations
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },
})
