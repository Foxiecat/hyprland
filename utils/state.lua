-- A key-value State persistence.
-- values are stored as plain text files under $XDG_RUNTIME_DIR/hypr/states/ .

-- @module utils.state

local state = {}
local helpers = require("utils.helpers")

local STATE_DIR = (os.getenv("XDG_RUNTIME_DIR") or "/tmp") .. "/hypr-states"

-- local helper functions
local function path(key)
	return STATE_DIR .. "/" .. key
end

local function ensure_dir()
	helpers.mkdir_p(STATE_DIR)
end

-- State functions

---Reads a state file to get stored value
---@param key string name of state file
---@param default any returned if key doesn't exist
---@return string|any
function state.get(key, default)
	ensure_dir()
	local data = helpers.read_file(path(key))
	if not data then
		state.set(key, default)
		return default
	end

	local value = helpers.trim(data)
	return value ~= "" and value or default
end

---Writes a state value.
---@param key string key used as name for state file
---@param value string|any
function state.set(key, value)
	ensure_dir()
	helpers.write_file(path(key), tostring(value))
end

---Deletes an existing state key
---@param key string the State key
function state.delete(key)
	os.remove(path(key))
end

return state
