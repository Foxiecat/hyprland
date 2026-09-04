-- .▄▄ · ▄▄▄▄▄ ▄▄▄· ▄▄▄  ▄▄▄▄▄▄• ▄▌ ▄▄▄·
-- ▐█ ▀. •██  ▐█ ▀█ ▀▄ █·•██  █▪██▌▐█ ▄█
-- ▄▀▀▀█▄ ▐█.▪▄█▀▀█ ▐▀▀▄  ▐█.▪█▌▐█▌ ██▀·
-- ▐█▄▪▐█ ▐█▌·▐█ ▪▐▌▐█•█▌ ▐█▌·▐█▄█▌▐█▪·•
--  ▀▀▀▀  ▀▀▀  ▀  ▀ .▀  ▀ ▀▀▀  ▀▀▀ .▀
--
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start hyprland-session.target")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("runapp noctalia")
  hl.exec_cmd("xhost +SI:localuser:root")

  hl.exec_cmd("runapp easyeffects --service-mode")
  hl.exec_cmd("runapp wl-paste --watch cliphist store")
  hl.exec_cmd("runapp arch-update --tray")
end)

hl.on("hyprland.shutdown", function()
  os.execute("systemctl --user stop graphical-session.target")
end)
