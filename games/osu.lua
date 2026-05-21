local json = require("dkjson")
local helpers = require("utils.helpers")

local OTD_SETTINGS = os.getenv("HOME") .. "/.config/OpenTabletDriver/settings.json"
local TARGET_TABLET = "Wacom PTK-470"
local rotation = 0

local function update_tablet_settings(tablet_name, path, new_value)
	local content = helpers.read_file(OTD_SETTINGS)

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
		if profile.Tablet == tablet_name then
			local node = profile
			for i = 1, #path - 1 do
				node = node[path[i]]
			end
			node[path[#path]] = new_value
			changed = true
			break
		end
	end

	if not changed then
		hl.notification.create({ text = "Tablet profile not found: " .. tablet_name, timeout = 3000, icon = "warning" })
		return
	end

	local contents = json.encode(data, { indent = true })
	helpers.write_file(OTD_SETTINGS, contents)

	os.execute("systemctl --user restart opentabletdriver.service")
	hl.notification.create({ text = "OTD settings updated!", timeout = 2000, icon = "ok" })
end

local flip = 0 -- 0 -> normal (no flips) | 2 -> 180 degrees
hl.bind("SUPER + SHIFT + A", function()
	rotation = (rotation == 180) and 0 or 180
	update_tablet_settings(TARGET_TABLET, { "AbsoluteModeSettings", "Tablet", "Rotation" }, rotation)

	flip = (flip == 2) and 0 or 2
	hl.monitor({ output = "DP-1", transform = flip })
end)
