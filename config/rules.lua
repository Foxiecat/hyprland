-- __________       __
-- \______   \__ __|  |   ____   ______
--  |       _/  |  \  | _/ __ \ /  ___/
--  |    |   \  |  /  |_\  ___/ \___ \
--  |____|_  /____/|____/\___  >____  >
--         \/                \/     \/

-- https://wiki.hyprland.org/Configuring/Basics/Window-Rules/

-- Window Rules
hl.window_rule({ match = { class = "osu!", title = "osu!" }, content = "game" })

hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = { class = "xwaylandvideobridge" },
	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = "1 1",
	opacity = 0.0,
})

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Float:
hl.window_rule({ match = { float = true, class = "^(org.pulseaudio.pavucontrol)" } })
hl.window_rule({ match = { float = true, class = "^()$", title = "^(Picture in Picture)$" } })
hl.window_rule({ match = { float = true, class = "^()$", title = "^(Save File)$" } })
hl.window_rule({ match = { float = true, class = "^()$", title = "^(Open File)$" } })
hl.window_rule({ match = { float = true, class = "^(LibreWolf)$", title = "^(Picture-in-Picture)$" } })
hl.window_rule({ match = { float = true, class = "^(blueman-manager)$" } })
hl.window_rule({ match = { float = true, class = "^(xdg-desktop-portal-hyprland)(.*)$" } })
hl.window_rule({ match = { float = true, class = "^(CachyOSHello)$" } })
hl.window_rule({ match = { float = true, class = "^(zenity)$" } })
hl.window_rule({ match = { float = true, class = "^()$", title = "^(Steam - Self Updater)$", workspace = "2" } })
hl.window_rule({ match = { float = true, class = "steam", title = "Friends List" } })
hl.window_rule({ match = { float = true, class = "^(jetbrains-toolbox)$" } })

-- https://wiki.hyprland.org/Configuring/Basics/Window-Rules/#layer-rules
-- Layer Rules
hl.layer_rule({
	name = "noctalia",
	match = { namespace = "noctalia-background-.*$" },
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
hl.layer_rule({ match = { namespace = "noctalia-shell:regionSelector" }, no_anim = true })

-- https://wiki.hyprland.org/Configuring/Basics/Workspace-Rules/
-- Workspace Rules

hl.workspace_rule({ workspace = "1", default = true, monitor = "DP-1", persistent = true })
hl.workspace_rule({
	workspace = "2",
	monitor = "DP-1",
	persistent = true,
	gaps_out = 0,
	gaps_in = 0,
	no_border = true,
	no_rounding = true,
})
hl.workspace_rule({ workspace = "3", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })

hl.workspace_rule({
	workspace = "6",
	persistent = true,
	layout = "scrolling",
})

for i = 6, 10 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "HDMI-A-1",
		layout_opts = {
			direction = "right",
			scrolling_width = 0.5,
		},
	})
end

-- Smart Gaps
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })

-- ============================================
-- SPECIAL WORKSPACES
-- ============================================
hl.workspace_rule({ workspace = "special:volumecontrol", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({
	workspace = "special:scratchpad",
	monitor = "DP-1",
	layout = "scrolling",
	layout_opts = {
		direction = "right",
		scrolling_width = 0.5,
	},
})
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, workspace = "special:volumecontrol" })
