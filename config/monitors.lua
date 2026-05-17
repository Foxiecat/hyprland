-- • ▌ ▄ ·.        ▐ ▄  ▪  ▄▄▄▄▄      ▄▄▄  .▄▄ ·
-- ·██ ▐███▪▪     •█▌▐█ ██ •██  ▪     ▀▄ █·▐█ ▀.
-- ▐█ ▌▐▌▐█· ▄█▀▄ ▐█▐▐▌ ▐█· ▐█.▪ ▄█▀▄ ▐▀▀▄ ▄▀▀▀█▄
-- ██ ██▌▐█▌▐█▌.▐▌██▐█▌ ▐█▌ ▐█▌·▐█▌.▐▌▐█•█▌▐█▄▪▐█
-- ▀▀  █▪▀▀▀ ▀█▄▀▪▀▀ █▪ ▀▀▀ ▀▀▀  ▀█▄▀▪.▀  ▀ ▀▀▀▀
--
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
	output = "DP-1",
	mode = "5120x1440@240.000",
	position = "0x0",
	scale = 1,
	vrr = 1,
	bitdepth = 10,
	cm = "edid",
	sdr_min_luminance = 0,
	sdr_max_luminance = 225,
	min_luminance = 0,
	max_luminance = 1000,
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "2560x1440@143.91",
	scale = 1,
	position = "-1440x-1120",
	transform = 1,
	bitdepth = 10,
	vrr = 0,
})
