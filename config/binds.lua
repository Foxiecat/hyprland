-- ▄▄▄▄· ▪   ▐ ▄ ·▄▄▄▄  .▄▄ ·
-- ▐█ ▀█▪██ •█▌▐███▪ ██ ▐█ ▀.
-- ▐█▀▀█▄▐█·▐█▐▐▌▐█· ▐█▌▄▀▀▀█▄
-- ██▄▪▐█▐█▌██▐█▌██. ██ ▐█▄▪▐█
-- ·▀▀▀▀ ▀▀▀▀▀ █▪▀▀▀▀▀•  ▀▀▀▀
--
-- https://wiki.hypr.land/Configuring/Basics/Binds/

local state = require("utils.state")

local mainMod = "SUPER"
local ipc = "qs -c noctalia-shell ipc call "
local terminal = "runapp wezterm"
local file_manager = "runapp thunar"
local browser = "runapp firefox"

-- Helper functions
local function exec(cmd)
	return hl.dsp.exec_cmd(cmd)
end

-- HDR Toggle
local dp1_cm = state.get("dp1_cm", "edid")
hl.bind(mainMod .. "+ SHIFT + B", function()
	dp1_cm = (dp1_cm == "hdredid") and "edid" or "hdredid"

	hl.monitor({ output = "DP-1", cm = dp1_cm })

	state.set("dp1_cm", dp1_cm)
end)

-- Noctalia
hl.bind(mainMod .. "+ SPACE", exec(ipc .. "launcher toggle"))
hl.bind(mainMod .. "+ comma", exec(ipc .. "settings toggle"))
hl.bind(mainMod .. "+ SHIFT + S", exec(ipc .. "plugin:screen-shot-and-record screenshot"))

-- Hyprland
hl.bind(mainMod .. "+ RETURN", exec(terminal))
hl.bind(mainMod .. "+ E", exec(file_manager))
hl.bind(mainMod .. "+ B", exec(browser))
hl.bind(mainMod .. "+ Q", hl.dsp.window.close())
hl.bind(mainMod .. "+ SHIFT + Q", hl.dsp.window.kill())
hl.bind(mainMod .. "+ F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. "+ M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. "+ T", hl.dsp.window.float())

hl.bind(mainMod .. "+ C", hl.dsp.window.center("activewindow"))
hl.bind(mainMod .. "+ left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "+ right", hl.dsp.focus({ direction = "right" }))
-- hl.bind(mainMod .. "+ up", hl.dsp.focus({ direction = "up" }))
-- hl.bind(mainMod .. "+ down", hl.dsp.focus({ direction = "down" }))

-- hl.bind(mainMod .. "+ left", hl.dsp.layout("focus l"))
-- hl.bind(mainMod .. "+ right", hl.dsp.layout("focus r"))

hl.bind(mainMod .. "+ CTRL + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. "+ CTRL + right", hl.dsp.window.move({ direction = "r" }))

Scrolling_Swapcol_L = hl.bind(mainMod .. "+ SHIFT + left", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. "+ SHIFT + right", hl.dsp.layout("swapcol r"))

hl.bind(mainMod .. "+ SHIFT + plus", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. "+ SHIFT + minus", hl.dsp.layout("colresize -conf"))

hl.bind(mainMod .. "+ mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. "+ mouse:273", hl.dsp.window.resize(), { mouse = true })

for i = 0, 10 do
	local key = i % 10
	hl.bind(mainMod .. "+" .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. "+ SHIFT +" .. key, hl.dsp.window.move({ workspace = i, follow = false }))
	hl.bind(mainMod .. "+ CTRL +" .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e+1" }))
