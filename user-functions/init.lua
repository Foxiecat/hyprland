-- @module user-functions

local user = {}

local function load_module(name)
	local ok, module = pcall(require, "user-functions." .. name)
	if not ok then
		print("Warning: Failed to load user-functions." .. name .. ": " .. tostring(module))
	end
	return module
end

-- =====================
-- || Modules to load ||
-- =====================

user.window = load_module("window")
user.osu = load_module("osu")

-- TODO: Switch Layout function that enables and disables keybinds specifically for the layout being switched from

return user
