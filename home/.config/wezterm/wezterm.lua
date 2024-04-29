-- Pull the wezterm API
local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
	config:set_strict_mode(true)
end

local scheme = wezterm.color.get_builtin_schemes()['Tokyo Night']
scheme.tab_bar.active_tab.intensity = 'Bold'
scheme.tab_bar.active_tab.underline = 'Single'
scheme.tab_bar.inactive_tab_hover.italic = true

config.color_schemes = {
	['Tokyo Night'] = scheme,
}
config.color_scheme = 'Tokyo Night'

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95

config.font = wezterm.font_with_fallback {
	{ family = 'Berkeley Mono', weight = 'Regular' },
	'Symbols Nerd Font',
}
config.font_size = 14.0

return config
