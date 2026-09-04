
-- https://wiki.hyprland.org/Configuring/Basics/Workspace-Rules/
-- Workspace Rules
hl.workspace_rule({ workspace = "1", monitor = PRIMARY_MONITOR, default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = PRIMARY_MONITOR, default = true, persistent = true })
hl.workspace_rule({ workspace = "3", monitor = PRIMARY_MONITOR, default = true, persistent = true })
hl.workspace_rule({ workspace = "name:gaming", monitor = PRIMARY_MONITOR, default = true, layout = "scrolling" })

hl.workspace_rule({ workspace = "4", monitor = MONITOR2, persistent = true, layout = "scrolling" })
hl.workspace_rule({ workspace = "5", monitor = MONITOR2, persistent = true, layout = "scrolling" })
hl.workspace_rule({ workspace = "6", monitor = MONITOR2, persistent = true, layout = "scrolling" })

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
hl.workspace_rule({
	workspace = "special:volumecontrol",
	layout = "scrolling",
	layout_opts = {
		direction = "right",
		column_width = 0.5,
	},
	persistent = true,
})
hl.workspace_rule({
	workspace = "special:scratchpad",
	monitor = "DP-1",
	layout = "scrolling",
	layout_opts = {
		direction = "right",
		scrolling_width = 0.5,
	},
})
