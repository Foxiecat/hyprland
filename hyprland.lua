ConfigDir = os.getenv("HOME") .. "/.config/hypr"

-- ============================================
-- MONITOR CONFIGURATION
-- ============================================

-- Default fallback for any unconfigured monitor
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- ============================================
-- LOAD CONFIGURATION MODULES
-- ============================================
require("config.config")
require("config.devices")
require("config.rules")
require("config.game_rules")
require("config.animations")
require("noctalia/noctalia-colors")
require("user-functions.osu")

user = require("user-functions.init")

require("config.binds")
require("config.startup")
