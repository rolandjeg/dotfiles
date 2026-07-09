local wezterm = require("wezterm")

local config = wezterm.config_builder()

local custom = wezterm.color.get_builtin_schemes()["tokyonight_night"]
custom.ansi[1] = "#15161e"
custom.ansi[2] = "#f34765"
custom.ansi[3] = "#71ab32"
custom.ansi[4] = "#c2862e"
custom.ansi[5] = "#4b80f2"
custom.ansi[6] = "#9768ee"
custom.ansi[7] = "#4abcff"
custom.ansi[8] = "#a9b1d6"

local kanagawa = wezterm.plugin.require("https://github.com/sravioli/kanagawa.wz")
kanagawa.register(config)
config.color_scheme = "Kanagawa Wave"
--config.color_scheme = "tokyonight_night"

wezterm.on("toggle-colorscheme", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.color_scheme then
		overrides.color_scheme = "Kanagawa Lotus"
		os.execute(
			"tmux set -g @ukiyo-theme kanagawa/lotus && tmux run '~/.tmux/plugins/tpm/tpm' && echo light > ~/.background && pkill -SIGUSR1 nvim"
		)
	else
		overrides.color_scheme = nil
		os.execute(
			"tmux set -g @ukiyo-theme kanagawa/wave && tmux run '~/.tmux/plugins/tpm/tpm' && echo dark > ~/.background && pkill -SIGUSR1 nvim"
		)
	end
	window:set_config_overrides(overrides)
end)

config.enable_tab_bar = false
config.font_size = 13.0
config.font = wezterm.font("Comic Code")
config.window_background_opacity = 0.84
config.window_decorations = "RESIZE"
config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}
-- keys = {
-- {key="Enter", mods="CTRL", action=wezterm.action{SendString='\u{000A}'}},
-- },
config.keys = {
	{
		key = "E",
		mods = "CTRL",
		action = wezterm.action.EmitEvent("toggle-colorscheme"),
	},
}

return config
