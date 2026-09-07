local wezterm = require("wezterm")

local config = wezterm.config_builder()

local kanagawa = wezterm.plugin.require("https://github.com/sravioli/kanagawa.wz")
kanagawa.register(config, {
	scheme_overrides = {
		wave = {
			ansi = {
				"#15161e",
				"#f34765",
				"#71ab32",
				"#c2862e",
				"#4b80f2",
				"#9768ee",
				"#4abcff",
				"#a9b1d6",
			},
			brights = {
				"#727169",
				"#E82424",
				"#98BB6C",
				"#E6C384",
				"#7FB4CA",
				"#938AA9",
				"#7AA89F",
				"#DCD7BA",
			},
		},
	},
})
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
