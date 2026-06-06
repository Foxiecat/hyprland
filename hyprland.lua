ConfigDir = os.getenv("HOME") .. "/.config/hypr"

-- ============================================
-- MONITOR CONFIGURATION
-- ============================================

-- Default fallback for any unconfigured monitor
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- Samsung Odyssey Oled G9 G93SC
hl.monitor({
	output = "DP-1",
	mode = "5120x1440@240.000",
	position = "0x0",
	scale = 1,
	vrr = 1,
	bitdepth = 10,
	cm = "edid",
	sdr_min_luminance = 0,
	sdr_max_luminance = 225,
	min_luminance = 0,
	max_luminance = 1000,
})

-- Samsung Odyssey G7 27"
hl.monitor({
	output = "HDMI-A-1",
	mode = "2560x1440@143.91",
	scale = 1,
	position = "-1440x-1120",
	transform = 1,
	bitdepth = 10,
	vrr = 0,
})

-- ============================================
-- LOAD CONFIGURATION MODULES
-- ============================================
require("config.config")
require("config.rules")
require("config.game_rules")
require("config.animations")
require("noctalia/noctalia-colors")
require("user-functions.osu")

user = require("user-functions.init")

require("config.binds")
require("config.startup")
