-- ▄▄▄▄· ▪   ▐ ▄ ·▄▄▄▄  .▄▄ ·
-- ▐█ ▀█▪██ •█▌▐███▪ ██ ▐█ ▀.
-- ▐█▀▀█▄▐█·▐█▐▐▌▐█· ▐█▌▄▀▀▀█▄
-- ██▄▪▐█▐█▌██▐█▌██. ██ ▐█▄▪▐█
-- ·▀▀▀▀ ▀▀▀▀▀ █▪▀▀▀▀▀•  ▀▀▀▀
--
-- https://wiki.hypr.land/Configuring/Basics/Binds/

local state = require("utils.state")
local notify = require("utils.notify")

local mainMod = "SUPER"
local noctCall = "noctalia msg "
local launchPrefix = "runapp "


--------------------------
---- HELPER FUNCTIONS ----
--------------------------

local function layout_bind(bind_table)
	return function()
		local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

		if not workspace then
			return
		end

		local layout = workspace.tiled_layout

		if bind_table[layout] then
			hl.dispatch(bind_table[layout])
		end
	end
end

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------

-- Window manipulation
hl.bind(mainMod .. " + Escape",       hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + Q",            hl.dsp.window.close())
hl.bind(mainMod .. " + ALT + Space",  hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",            hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + F11",          hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + J",            hl.dsp.layout("togglesplit"))

-- Change focus
hl.bind(mainMod .. " + Left",   hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right",  hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down",   hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab",            hl.dsp.window.cycle_next())

-- Core
hl.bind(mainMod .. " + RETURN",     hl.dsp.exec_cmd(launchPrefix .. TERMINAL))
hl.bind(mainMod .. " + E",          hl.dsp.exec_cmd(launchPrefix .. FILE_MANAGER))
hl.bind(mainMod .. " + B",          hl.dsp.exec_cmd(launchPrefix .. BROWSER))
hl.bind(mainMod .. " + Z",          hl.dsp.exec_cmd(noctCall .. "settings-toggle"))
hl.bind(mainMod .. " + X",          hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center"))
hl.bind(mainMod .. " + Space",      hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher"))
hl.bind(mainMod .. " + L",          hl.dsp.exec_cmd(noctCall .. "session lock"))
hl.bind(mainMod .. " + ALT + C",    hl.dsp.exec_cmd(noctCall .. "panel-toggle session"))
hl.bind(mainMod .. " + SHIFT + S",  hl.dsp.exec_cmd(noctCall .. "screenshot-region"))
hl.bind(mainMod .. " + P",          hl.dsp.exec_cmd(noctCall .. "bar-toggle DP-1"))

hl.bind(mainMod .. " + CTRL + Return", hl.dsp.layout("swapwithmaster master"), { desc = "Swap with master" })

-- Scrolling layout
hl.bind(mainMod .. " + plus",             hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + minus",            hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. " + I",                hl.dsp.layout("inhibit_scroll"))
hl.bind(mainMod .. " + CONTROL + Left",       hl.dsp.layout("focus left"))
hl.bind(mainMod .. " + CONTROL + Right",      hl.dsp.layout("focus right"))
hl.bind(mainMod .. " + period",           hl.dsp.layout("consume_or_expel next"))
hl.bind(mainMod .. " + comma",            hl.dsp.layout("consume_or_expel prev"))

-- Mouse
hl.bind(mainMod .. "+ mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. "+ mouse:273", hl.dsp.window.resize(), { mouse = true })

-------------------------------
---- WORKSPACES & MONITORS ----
-------------------------------

-- Focus on monitors
hl.bind(mainMod .. " + 1", hl.dsp.focus({ monitor = MONITOR1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ monitor = MONITOR2 }))

-- Focus on workspace number
-- Absolute
for i = 1, NUM_WPM do
	local key = i % 10
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.focus({ workspace = i }))
end
-- Relative
for i = 1, NUM_WPM do
	local key = i % 10
	hl.bind(mainMod .. " + CONTROL + " .. key, hl.dsp.focus({ workspace = "m~" .. i }))
end

-- Move active window around workspaces & monitors
hl.bind(mainMod .. "+ SHIFT + Left",
  layout_bind({
    master = hl.dsp.window.move({ direction = "l"}),
    scrolling = hl.dsp.layout("swapcol l")
  }))
hl.bind(mainMod .. "+ SHIFT + Right",
  layout_bind({
    master = hl.dsp.window.move({ direction = "r"}),
    scrolling = hl.dsp.layout("swapcol r")
  }))

hl.bind(mainMod .. " + SHIFT + Up",                   hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + Down",                 hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + 1",                    hl.dsp.window.move({ monitor = MONITOR1 }))
hl.bind(mainMod .. " + SHIFT + 2",                    hl.dsp.window.move({ monitor = MONITOR2 }))
hl.bind(mainMod .. " + CONTROL + SHIFT + Down",      hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + Up",       hl.dsp.window.move({ workspace = "m-1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + mouse_up",   hl.dsp.window.move({ workspace = "m-1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "m+1" }))
for i = 1, NUM_WPM do
    local key = i % 10
    hl.bind(mainMod .. " + SHIFT + CONTROL + " .. key, hl.dsp.window.move({ workspace = "m~" .. i }))
end

-- Move to adjacent workspaces and next empty on a given monitor
hl.bind(mainMod .. " + CONTROL + Down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + CONTROL + Up",  hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CONTROL + ALT + Down",  hl.dsp.focus({ workspace = "emptym" }))

-- Scroll through existing workspaces & monitors
hl.bind(mainMod .. " + mouse_down",           hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + mouse_up",             hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + CONTROL + mouse_up",   hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CONTROL + mouse_down", hl.dsp.focus({ workspace = "m+1" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + CONTROL + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + S",           hl.dsp.workspace.toggle_special())

------------------------------
---- DISCORD/VESKTO BINDS ----
------------------------------
hl.bind(
  mainMod .. "+ ALT + D",
  hl.dsp.send_shortcut({
    mods = "CONTROL + SHIFT",
    key = "D",
    window = "class:vesktop"
  }),
  { description = "Vesktop: Deafen" }
)

hl.bind(
  mainMod .. "+ ALT + M",
  hl.dsp.send_shortcut({
    mods = "CONTROL + SHIFT",
    key = "M",
    window = "class:vesktop"
  }),
  { description = "Vesktop: Mute" }
)

--------------------
---- OTHER BINDS ----
--------------------

local osu_res = "5120x1440@240.000"
local osu_layout = "master"
hl.bind(mainMod .. "+ SHIFT + O", function()
	osu_res = (osu_res == "2560x1440@240.000") and "5120x1440@240.000" or "2560x1440@240.000"
	osu_layout = (osu_layout == "master") and "scrolling" or "master"

	user.window.change_resolution(osu_res)
	user.window.change_layout(osu_layout)
	os.execute("systemctl --user restart opentabletdriver.service")
end)

local direct = 0
hl.bind(mainMod .. "+ SHIFT + D", function()
	direct = (direct == 1) and 0 or 1
	hl.config({
		render = {
			direct_scanout = direct,
		},
	})
	notify.success("Direct Scanout: " .. direct)
end)

local flip = state.get("australian_mode", 0)
hl.bind("SUPER + SHIFT + A", function()
	local rotation = 0
	flip = (flip == 2) and 0 or 2

	if flip == 0 then
		rotation = 0
	elseif flip == 2 then
		rotation = 180
	end

	user.osu.australian_mode(flip, rotation)
end)

hl.bind(mainMod .. "+ tab", function()
	local layouts = { "scrolling", "master" }
	local workspace = hl.get_active_workspace()
	local next_layout = "master"

	if not workspace then
		return
	end

	for i = 1, #layouts do
		if layouts[i] == workspace.tiled_layout then
			local next_layout_idx = (i % #layouts) + 1
			next_layout = layouts[next_layout_idx]
			break
		end
	end

	hl.workspace_rule({ workspace = workspace.name, layout = next_layout })
end)

-- HDR Toggle
hl.bind(mainMod .. "+ SHIFT + B", function()
	user.window.hdr("DP-1")
end)

-- Special Applications
hl.bind(mainMod .. "+ V", hl.dsp.workspace.toggle_special("volumecontrol"))
