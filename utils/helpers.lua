-- @module utils.helpers

local helpers = {}

---Reads a files contents.
---@param path string Absolute file path
---@return string|nil file contents as string, or nil on error
function helpers.read_file(path)
	local file = io.open(path, "r")
	if not file then
		hl.notification.create({
			text = "Could not open " .. path,
			timeout = 3000,
			icon = "error",
		})
		return nil
	end

	local content = file:read("*a")
	file:close()
	return content
end

---Writes contents to a file, replacing existing content.
---@param path string Absolute file path
---@param contents string the contents to write
---@return boolean success
function helpers.write_file(path, contents)
	local file = io.open(path, "w")
	if not file then
		hl.notification.create({
			text = "Could not open " .. path,
			timeout = 3000,
			icon = "error",
		})
		return false
	end

	file:write(contents)
	file:close()
	return true
end

function helpers.mkdir_p(path)
	local result = os.execute("mkdir -p " .. path .. " 2>/dev/null")
	return result == 0 or result == true
end

function helpers.trim(string)
	return "'" .. (string or ""):gsub("'", [['\'']]) .. "'"
end

function helpers.safe_call(error_context, fn, default_value)
	local success, result = pcall(fn)
	if not success then
		local notify = require("utils.notify")
		notify.error(error_context, tostring(result))
		return default_value
	end
	return result
end

helpers.safe_call_with_return = helpers.safe_call

_G.helpers = helpers
return helpers
