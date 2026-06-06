local proc = {}
local helpers = require("utils.helpers")

---Return true if at least one process with this exact name is running.
---@param name string Process name
---@return boolean
function proc.running(name, exact)
	local cmd = "pgrep "

	if (exact == true) or (exact == nil) then
		cmd = cmd .. "-x "
	else
		cmd = cmd .. "-f "
	end

	local cmd = cmd .. helpers.shquote(name) .. " >/dev/null 2>&1"
	local r = helpers.exec(cmd)

	return r.exit_code == 0
end

return proc
