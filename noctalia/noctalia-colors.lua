local primary = 0xffcba6f7
local surface = 0xff1e1e2e
local secondary = 0xfffab387
local error = 0xfff38ba8
local tertiary = 0xff94e2d5
local surface_lowest = 0xff212232

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
			border_locked_active = error,
			border_locked_inactive = surface,
		},

		groupbar = {
			col = {
				active = secondary,
				inactive = surface,
				locked_active = error,
				locked_inactive = surface,
			},
		},
	},
})
