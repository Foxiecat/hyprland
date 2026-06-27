-- .▄▄ · ▄▄▄▄▄ ▄▄▄· ▄▄▄  ▄▄▄▄▄▄• ▄▌ ▄▄▄·
-- ▐█ ▀. •██  ▐█ ▀█ ▀▄ █·•██  █▪██▌▐█ ▄█
-- ▄▀▀▀█▄ ▐█.▪▄█▀▀█ ▐▀▀▄  ▐█.▪█▌▐█▌ ██▀·
-- ▐█▄▪▐█ ▐█▌·▐█ ▪▐▌▐█•█▌ ▐█▌·▐█▄█▌▐█▪·•
--  ▀▀▀▀  ▀▀▀  ▀  ▀ .▀  ▀ ▀▀▀  ▀▀▀ .▀
--
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	hl.exec_cmd("runapp qs -c noctalia-shell")

	-- Launch startup applications
	hl.exec_cmd("runapp pavucontrol", { workspace = "special:volumecontrol" })

	-- Clipboard manager
	hl.exec_cmd("runapp wl-paste --type text --watch cliphist store")
	hl.exec_cmd("runapp wl-paste --type image --watch cliphist store")
end)
