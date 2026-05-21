local notify = {}

local function shquote(string)
	return "'" .. tostring(string):gsub("'", [['\'']]) .. "'"
end

function notify.send(opts)
	opts = opts or {}

	local cmd = { "notify-send", "-e", "-t" .. tostring(opts.timeout or 3000) }

	if opts.icon and opts.icon ~= "" then
		table.insert(cmd, "-i " .. shquote(opts.icon))
	end

	if opts.urgency then
		table.insert(cmd, "-u" .. shquote(opts.urgency))
	end

	for _, hint in ipairs(opts.hints or {}) do
		table.insert(cmd, "-h " .. shquote(hint))
	end

	if opts.title then
		table.insert(cmd, shquote(opts.title))
		table.insert(cmd, shquote(opts.text or ""))
	else
		table.insert(cmd, shquote(opts.text or ""))
	end

	hl.exec_cmd(table.concat(cmd, " "))
end

function notify.error(message, details)
	local text = message
	if details and details ~= "" then
		text = text .. " (" .. tostring(details) .. ")"
	end
	notify.send({ text = text, icon = "error", timeout = 5000, urgency = "critical" })
end

function notify.success(message)
	notify.send({ text = message, icon = "info", timeout = 2000 })
end

function notify.info(message)
	notify.send({ text = message, icon = "info", timeout = 3000 })
end

return notify
