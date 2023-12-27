local wezterm = require 'wezterm'
local custom = wezterm.color.get_builtin_schemes()["Tokyo Night"]
custom.brights[1]="#6c7086"
--local custom = wezterm.color.get_builtin_schemes()["Gruvbox Material (Gogh)"]
return {
	-- color_scheme = 'termnial.sexy',
	--color_scheme = 'Catppuccin Mocha',
	color_schemes = {["rosspuccin"] = custom},
	color_scheme = "rosspuccin",
	enable_tab_bar = false,
	font_size = 18.0,
	font = wezterm.font 'Comic Code',
	-- macos_window_background_blur = 40,
	macos_window_background_blur = 30,
	
	--window_background_image = '~/wallpaper/cass.jpg',
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	-- window_background_opacity = 0.92,
	window_background_opacity = 0.85,
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
}
