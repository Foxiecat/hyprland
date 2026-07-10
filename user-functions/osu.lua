local osu = {}

local json = require("dkjson")
local helpers = require("utils.helpers")
local state = require("utils.state")

local osu_client = state.get("osu_client", "lazer")
function osu.toggle_stable_mode()
	osu_client = (osu_client == "stable") and "lazer" or "stable"
	if osu_client == "lazer" then
		hl.monitor({
			output = "DP-1",
			mode = "5120x1440@240.000",
		})
	elseif osu_client == "stable" then
		hl.monitor({
			output = "DP-1",
			mode = "2560x1440@240.000",
		})
	end
	state.set("osu_client", osu_client)
end

local flip = state.get("australian_mode", 0)
function osu.australian_mode()
	local rotation = 0

	flip = (flip == 2) and 0 or 2
	hl.monitor({ output = "DP-1", transform = flip })

	if flip == 0 then
		rotation = 0
	elseif flip == 2 then
		rotation = 180
	end

	local otd_settings = os.getenv("HOME") .. "/.config/OpenTabletDriver/settings.json"
	local content = helpers.read_file(otd_settings)
	local data, _, error = json.decode(content)
	if error then
		hl.notification.create({
			text = "JSON decode error: " .. error,
			timeout = 3000,
			icon = "error",
		})
		return
	end

	local json_path = { "AbsoluteModeSettings", "Tablet", "Rotation" }
	local changed = false
	for _, profile in ipairs(data.Profiles) do
		if profile.Tablet == "Wacom PTK-470" then
			local node = profile
			for i = 1, #json_path - 1 do
				node = node[json_path[i]]
			end
			node[json_path[#json_path]] = rotation
			changed = true
			break
		end
	end

	if not changed then
		hl.notification.create({
			text = "Tablet profile not found: Wacom PTK-470",
			timeout = 3000,
			icon = "warning",
		})
		return
	end

	local contents = json.encode(data, { indent = true })
	helpers.write_file(otd_settings, contents)

	os.execute("systemctl --user restart opentabletdriver.service")
	hl.notification.create({ text = "OTD settings updated!", timeout = 2000, icon = "ok" })
end

return osu
