local wezterm = require 'wezterm'
local custom = wezterm.color.get_builtin_schemes()["tokyonight_night"]
--custom.ansi[1] = "#15161e"
custom.ansi[2] = "#f34765"
custom.ansi[3] = "#71ab32"
custom.ansi[4] = "#c2862e"
custom.ansi[5] = "#4b80f2"
custom.ansi[6] = "#9768ee"
custom.ansi[7] = "#4abcff"
--custom.ansi[8] = "#a9b1d6"

custom.brights[1]="#6c7086"
--local custom = wezterm.color.get_builtin_schemes()["Gruvbox Material (Gogh)"]
return {
	-- color_scheme = 'termnial.sexy',
	--color_scheme = 'Catppuccin Mocha',
	color_schemes = {["rosstheme"] = custom},
	color_scheme = "rosstheme",
	--color_scheme = "tokyonight_night",
	enable_tab_bar = false,
	font_size = 13.0,
	font = wezterm.font 'Comic Code',
	-- enable_kitty_keyboard = true,
	-- macos_window_background_blur = 40,
	--macos_window_background_blur = 30,
	
	--window_background_image = '~/wallpaper/cass.jpg',
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	--window_background_opacity = 0.92,
	window_background_opacity = 0.84,
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	window_decorations = 'RESIZE',
	mouse_bindings = {
	  -- Ctrl-click will open the link under the mouse cursor
	  {
	    event = { Up = { streak = 1, button = 'Left' } },
	    mods = 'CTRL',
	    action = wezterm.action.OpenLinkAtMouseCursor,
	  },
	},
	-- keys = {
		-- {key="Enter", mods="CTRL", action=wezterm.action{SendString='\u{000A}'}},
	-- },
}
