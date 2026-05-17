-- @module utils.helpers

local helpers = {}

function helpers.read_file(path)
	local file = io.open(path, "r")
	if not file then
		hl.notification.create({
			text = "Could not open " .. path,
			timeout = 3000,
			icon = "error",
		})
		return
	end

	local content = file:read("*a")
	file:close()
	return content
end

function helpers.write_file(path, contents)
	local file = io.open(path, "w")
	if not file then
		hl.notification.create({
			text = "Could not open " .. path,
			timeout = 3000,
			icon = "error",
		})
		return
	end

	file:write(contents)
	file:close()
end

_G.helpers = helpers
return helpers
