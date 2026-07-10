local window = {}

local helpers = require("utils.helpers")
local notify = require("utils.notify")
local state = require("utils.state")

function window.force_special(pattern, ws)
	hl.on("window.open", function(w)
		Handler = hl.on("window.title", function(w2)
			if w.stable_id == w2.stable_id then
				if w.title:match(pattern) then
					hl.dispatch(hl.dsp.window.move({ workspace = ws, window = w }))
				end

				Handler:remove()
			end
		end)
	end)
end

function window.kill_active()
	helpers.safe_call("Kill active process failed", function()
		local w = hl.get_active_window()
		if not w or not w.pid or w.pid == 0 then
			notify.error("No active window found")
			return
		end
		helpers.exec("kill " .. tostring(w.pid))
	end)
end

local color_profile = state.get("color_profile", "wide")
---Toggle between HDR and SDR color profile
---@param output_str string Output device, aka a monitor or screen.
function window.hdr(output_str)
	color_profile = (color_profile == "hdr") and "wide" or "hdr"
	hl.monitor({ output = output_str, cm = color_profile })
	state.set("color_profile", color_profile)
end

return window
