-- .▄▄ · ▄▄▄ .▄▄▄▄▄▄▄▄▄▄▪   ▐ ▄  ▄▄ • .▄▄ ·
-- ▐█ ▀. ▀▄.▀·•██  •██  ██ •█▌▐█▐█ ▀ ▪▐█ ▀.
-- ▄▀▀▀█▄▐▀▀▪▄ ▐█.▪ ▐█.▪▐█·▐█▐▐▌▄█ ▀█▄▄▀▀▀█▄
-- ▐█▄▪▐█▐█▄▄▌ ▐█▌· ▐█▌·▐█▌██▐█▌▐█▄▪▐█▐█▄▪▐█
--  ▀▀▀▀  ▀▀▀  ▀▀▀  ▀▀▀ ▀▀▀▀▀ █▪·▀▀▀▀  ▀▀▀▀
--
-- https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
	input = {
		kb_layout = "no",
		kb_variant = "nodeadkeys",
		accel_profile = "flat",

		follow_mouse = 2,
		sensitivity = -0.4,
	},

	-- https://wiki.hypr.land/Configuring/Variables/#misc
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},

	cursor = {
		default_monitor = "DP-1",
		no_hardware_cursors = 1,
	},

	general = {
		gaps_in = 3,
		gaps_out = 6,

		border_size = 2,

		layout = "master",
		allow_tearing = true,
	},

	scrolling = {
		fullscreen_on_one_column = false,
		focus_fit_method = 0,
		follow_focus = true,
		column_width = 0.5,
		explicit_column_widths = "0.25, 0.5, 0.671875, 1",
		direction = "right",
	},

	-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
	master = {
		slave_count_for_center_master = 0,
		orientation = "center",
		mfact = 0.50,
	},

	decoration = {
		rounding = 20,
		rounding_power = 2,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
	},
})
