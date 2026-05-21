local primary = "rgba(7aa2f7bf)"
local surface = "rgba(1a1b26bf)"
local secondary = "rgb(bb9af7)"
local error_color = "rgb(f7768e)"
local tertiary = "rgb(9ece6a)"
local surface_lowest = "rgb(1c1d2a)"

hl.config({
	general = {
		col = {
			active_border = primary,
			inactive_border = surface,
		},
	},

	group = {
		col = {
			border_active = secondary,
			border_inactive = surface,
			border_locked_active = error_color,
			border_locked_inactive = surface,
		},

		groupbar = {
			col = {
				active = secondary,
				inactive = surface,
				locked_active = error_color,
				locked_inactive = surface,
			},
		},
	},
})
