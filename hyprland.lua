-- MISC
hl.config({
	cursor({
		default_monitor = "DP-1",
		no_hardware_cursors = 1,
	}),
})

-- MONITORS
hl.monitor({
	output = "DP-1",
	mode = "5120x1440@240.000",
	position = "0x0",
	scale = 1,
	vrr = 1,
	bitdepth = 10,
	cm = "edid",
	sdr_min_luminance = 0.005,
	sdr_max_luminance = 225,
	min_luminance = 0,
	max_luminance = 1000,
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "2560x1440@143.91",
	scale = 1,
	position = "-1440x-1120",
	transform = 1,
	bitdepth = 10,
	vrr = 1,
})

-- INPUT
hl.config({
	input({
		kb_layout = "no",
		kb_variant = "nodeadkeys",
		accel_profile = "flat",

		follow_mouse = 2,
		sensitivity = -0.4,
	}),
})

hl.device({
	name = "sony-interactive-entertainment-dualsense-wireless-controller-touchpad",
	enabled = false,
})

-- AUTOSTART
hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- qs -c noctalia-shell")
	hl.exec_cmd("uwsm app -- wl-paste --watch cliphist store")
	hl.exec_cmd("[workspace 2 silent] uwsm app -- steam")
	hl.exec_cmd("[workspace 6 silent] uwsm app -- vesktop")
	hl.exec_cmd("[workspace 7 silent] uwsm app -- app.fluxer.Fluxer")
end)

---------------------
--- LOOK AND FEEL ---
---------------------
hl.config({
	general({
		gaps_in = 3,
		gaps_out = 6,

		border_size = 2,

		layout = "master",
	}),

	-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
	master({
		slave_count_for_center_master = 0,
		orientation = "center",
		mfact = 0.50,
	}),

	-- https://wiki.hypr.land/Configuring/Variables/#misc
	misc({
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	}),

	decoration({
		rounding = 20,
		rounding_power = 2,

		shadow({
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		}),

		blur({
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		}),
	}),
})

-------------------
--- KEYBINDINGS ---
-------------------
local mainMod = "SUPER"
local ipc = "qs -c noctalia-shell ipc call"

hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/hypr/scripts/togglehdr.sh DP-1"))
