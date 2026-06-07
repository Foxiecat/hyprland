local window = {}

local helpers = require("utils.helpers")
local notify = require("utils.notify")

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

-- ============================================
-- KILL ACTIVE
-- ============================================

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

return window
