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
local terminal = "wezterm"
local file_manager = "thunar"
local browser = "app.zen_browser.zen"

-- Helper functions
local function exec(cmd)
	return hl.dsp.exec_cmd(cmd)
end

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

-- ============================================
-- CORE BINDS
-- ============================================

-- Noctalia
hl.bind(mainMod .. "+ SPACE", exec(ipc .. "launcher toggle"))
hl.bind(mainMod .. "+ comma", exec(ipc .. "settings toggle"))
hl.bind(mainMod .. "+ SHIFT + S", exec(ipc .. "plugin:screen-shot-and-record screenshot"))
hl.bind(mainMod .. "+ C", exec(ipc .. "plugin:clipper toggle"))

-- Core
hl.bind(mainMod .. "+ RETURN", exec(terminal))
hl.bind(mainMod .. "+ Q", hl.dsp.window.close())
hl.bind(mainMod .. "+ SHIFT + Q", hl.dsp.window.kill())
hl.bind(mainMod .. "+ E", exec(file_manager))
hl.bind(mainMod .. "+ B", exec(browser))
hl.bind(mainMod .. "+ F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. "+ M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. "+ T", hl.dsp.window.float())

-- Layout Binds
hl.bind(
	mainMod .. "+ up",
	layout_bind({
		master = hl.dsp.focus({ direction = "up" }),
		scrolling = hl.dsp.layout("focus up"),
	})
)
hl.bind(
	mainMod .. "+ down",
	layout_bind({
		master = hl.dsp.focus({ direction = "down" }),
		scrolling = hl.dsp.layout("focus down"),
	})
)
hl.bind(
	mainMod .. "+ left",
	layout_bind({
		master = hl.dsp.focus({ direction = "left" }),
		scrolling = hl.dsp.layout("focus left"),
	})
)
hl.bind(
	mainMod .. "+ right",
	layout_bind({
		master = hl.dsp.focus({ direction = "right" }),
		scrolling = hl.dsp.layout("focus right"),
	})
)
hl.bind(
	mainMod .. "+ CTRL + left",
	layout_bind({
		master = hl.dsp.window.move({ direction = "l" }),
		scrolling = hl.dsp.layout("swapcol l"),
	})
)
hl.bind(
	mainMod .. "+ CTRL + right",
	layout_bind({
		master = hl.dsp.window.move({ direction = "r" }),
		scrolling = hl.dsp.layout("swapcol r"),
	})
)
hl.bind(
	mainMod .. "+ CTRL + comma",
	layout_bind({
		scrolling = hl.dsp.layout("move -col"),
	})
)
hl.bind(
	mainMod .. "+ CTRL + period",
	layout_bind({
		scrolling = hl.dsp.layout("move +col"),
	})
)

-- Master Layout
hl.bind(mainMod .. "+ I", hl.dsp.layout("addmaster"), { desc = "Add master (master layout)" })
hl.bind(mainMod .. " + CTRL + D", hl.dsp.layout("removemaster"), { desc = "Remove master (master layout)" })
hl.bind(mainMod .. " + CTRL + Return", hl.dsp.layout("swapwithmaster master"), { desc = "Swap with master" })

-- Scrolling layout
hl.bind(mainMod .. "+ plus", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. "+ minus", hl.dsp.layout("colresize -conf"))

-- Mouse
hl.bind(mainMod .. "+ mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. "+ mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspaces
hl.bind(
	mainMod .. "+ CTRL + S",
	hl.dsp.window.move({ workspace = "special:scratchpad" }),
	{ desc = "Move focused window to scratchpad" }
)
hl.bind(mainMod .. "+ S", hl.dsp.workspace.toggle_special("scratchpad"), { desc = "Toggle scratchpad" })

for i = 0, 10 do
	local key = i % 10
	hl.bind(mainMod .. "+" .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. "+ SHIFT +" .. key, hl.dsp.window.move({ workspace = i, follow = false }))
	hl.bind(mainMod .. "+ CTRL +" .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. "+ CTRL + up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. "+ CTRL + down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. "+ mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. "+ mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. "+ CTRL + mouse_down", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. "+ CTRL + mouse_up", hl.dsp.window.move({ workspace = "e+1" }))

-- ============================================
-- USER BINDS
-- ============================================

--#region osu
local osu_res = "5120x1440@240.000"
local osu_layout = "master"
hl.bind(mainMod .. "+ SHIFT + O", function()
	osu_res = (osu_res == "2560x1440@240.000") and "5120x1440@240.000" or "2560x1440@240.000"
	osu_layout = (osu_layout == "scrolling") and "master" or "scrolling"

	user.window.change_resolution(osu_res)
	user.window.change_layout(osu_layout)
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
--#endregion osu

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
