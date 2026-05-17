-- __________       __
-- \______   \__ __|  |   ____   ______
--  |       _/  |  \  | _/ __ \ /  ___/
--  |    |   \  |  /  |_\  ___/ \___ \
--  |____|_  /____/|____/\___  >____  >
--         \/                \/     \/

-- https://wiki.hyprland.org/Configuring/Basics/Window-Rules/

local function setFirefoxScrollingWidth()
	local windows = hl.get_workspace_windows(hl.get_active_workspace().id)
	for _, window in ipairs(windows) do
		if window.class == "firefox" then
			return 0.25
		end
	end
	return 0.5
end

-- Window Rules

hl.window_rule({
	name = "Firefox-width",
	match = { class = "firefox" },
	scrolling_width = setFirefoxScrollingWidth(),
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
	layout_opts = { direction = "right" },
})

for i = 6, 10 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1" })
end

-- Smart Gaps
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })
