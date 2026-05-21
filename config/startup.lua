-- .▄▄ · ▄▄▄▄▄ ▄▄▄· ▄▄▄  ▄▄▄▄▄▄• ▄▌ ▄▄▄·
-- ▐█ ▀. •██  ▐█ ▀█ ▀▄ █·•██  █▪██▌▐█ ▄█
-- ▄▀▀▀█▄ ▐█.▪▄█▀▀█ ▐▀▀▄  ▐█.▪█▌▐█▌ ██▀·
-- ▐█▄▪▐█ ▐█▌·▐█ ▪▐▌▐█•█▌ ▐█▌·▐█▄█▌▐█▪·•
--  ▀▀▀▀  ▀▀▀  ▀  ▀ .▀  ▀ ▀▀▀  ▀▀▀ .▀
--
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	hl.exec_cmd("runapp qs -c noctalia-shell")
	hl.exec_cmd("runapp wl-paste --watch cliphist store") -- Enable clipboard for images
	hl.exec_cmd("runapp steam", { workspace = 2 })
	hl.exec_cmd("runapp vesktop", { workspace = 6 })
end)
