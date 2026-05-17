configDir = os.getenv("HOME") .. "/.config/hypr"

require("config.startup")
require("config.monitors")
require("config.binds")
require("config.config")
require("config.rules")
require("config.game_rules")
require("config.animations")
require("noctalia/noctalia-colors")

require("games.osu")
