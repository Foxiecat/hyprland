local osu = {}

local json = require("dkjson")
local helpers = require("utils.helpers")

--- Flip monitor upside down. Australian Mode is a style of breaking mind block in Osu by flipping it upside down.
---@param flip_monitor number
---@param tablet_rotation number
function osu.australian_mode(flip_monitor, tablet_rotation)
	hl.monitor({ output = "DP-1", transform = flip_monitor })

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
			node[json_path[#json_path]] = tablet_rotation
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
