hl.window_rule({
	name = "Elden Ring",
	match = {
		title = "Elden Ring",
		fullscreen = true,
		content = 3,
	},
	workspace = "3",
})

hl.window_rule({
	name = "Elder Scrolls Online",
	match = {
		title = "Elder Scrolls Online",
		fullscreen = false,
		float = false,
	},
	workspace = "3",
})

-- Osu
hl.window_rule({
  match = {
    class = "^(osu!|osu!.exe)$",
  },
  workspace = "name:gaming",
  content = "game",
  decorate         = false,
  fullscreen_state = 2,
  size             = { "monitor_w", "monitor_h" },
  sync_fullscreen  = true,
  immediate = 1,
})
