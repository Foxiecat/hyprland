local osu = {}

local json = require("dkjson")
local helpers = require("utils.helpers")
local state = require("utils.state")

local otd_settings = os.getenv("HOME") .. "/.config/OpenTabletDriver/settings.json"
local target_tablet = "Wacom PTK-470"
local json_path = { "AbsoluteModeSettings", "Tablet", "Rotation" }
local flip = state.get("australian_mode", 0)
local rotation = 0

function osu.australian_mode()
	flip = (flip == 2) and 0 or 2
	hl.monitor({ output = "DP-1", transform = flip })

	if flip == 0 then
		rotation = 0
	elseif flip == 2 then
		rotation = 180
	end

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

	-- Filter to correct tablet profile
	local changed = false
	for _, profile in ipairs(data.Profiles) do
		if profile.Tablet == target_tablet then
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
			text = "Tablet profile not found: " .. target_tablet,
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
