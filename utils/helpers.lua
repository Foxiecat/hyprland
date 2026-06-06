-- @module utils.helpers

local helpers = {}
local callbacks = {}

local function exec_id()
	return tostring(os.time()) .. "_" .. tostring(math.random(10000, 99999))
end

local function exec_files(id)
	local base = "/tmp/exec_" .. id

	return base .. ".out", base .. ".ec", base .. ".sh"
end

local function write_exec_script(id, cmd, tail)
	local outfile, ecfile, scriptfile = exec_files(id)

	helpers.write_file(
		scriptfile,
		string.format("#!/bin/sh\n{\n(%s)\n} > %s 2>&1\necho $? > %s\n%s", cmd, outfile, ecfile, tail or "")
	)

	return scriptfile
end

local function collect_exec_result(outfile, ecfile)
	local result = { success = false, stdout = "", stderr = "" }
	local of = io.open(outfile, "r")

	if of then
		result.stdout = of:read("*a") or ""
		of:close()
		os.remove(outfile)
	end

	local ef = io.open(ecfile, "r")

	if ef then
		local code = tonumber(ef:read("*a"):match("%d+"))

		ef:close()
		os.remove(ecfile)

		result.exit_code = code
		result.success = (code == 0)
	end

	return result
end

---@param cmd string Shell command to run
---@return table { success = boolean, stdout = string, exit_code = number, stderr = string }
function helpers.exec(cmd)
	local id = exec_id()
	local outfile, ecfile, scriptfile = exec_files(id)

	write_exec_script(id, cmd)

	os.execute("chmod +x " .. scriptfile .. " && " .. scriptfile)
	os.remove(scriptfile)

	return collect_exec_result(outfile, ecfile)
end

---@param cmd string Shell command to run
---@param cb closure Called with (exit_code, stdout_stderr) where exit_code is a number
function helpers.exec_async(cmd, cb)
	local id = exec_id()

	callbacks[id] = cb

	local scriptfile = write_exec_script(
		id,
		cmd,
		string.format("hyprctl eval 'helpers.exec_callback(\"%s\")'\nrm -f /tmp/exec_%s.sh\n", id, id)
	)

	hl.exec_cmd("chmod +x " .. scriptfile .. " && " .. scriptfile .. " &")
end

function helpers.exec_callback(id)
	local cb = callbacks[id]

	callbacks[id] = nil

	if not cb then
		return
	end

	local outfile, ecfile = exec_files(id)
	local result = collect_exec_result(outfile, ecfile)

	cb(result.exit_code or 0, result.stdout)
end

---Reads a files contents.
---@param path string Absolute file path
---@return string|nil file contents as string, or nil on error
function helpers.read_file(path)
	local file = io.open(path, "r")
	if not file then
		hl.notification.create({
			text = "Could not open " .. path,
			timeout = 3000,
			icon = "error",
		})
		return nil
	end

	local content = file:read("*a")
	file:close()
	return content
end

---Writes contents to a file, replacing existing content.
---@param path string Absolute file path
---@param contents string the contents to write
---@return boolean success
function helpers.write_file(path, contents)
	local file = io.open(path, "w")
	if not file then
		hl.notification.create({
			text = "Could not open " .. path,
			timeout = 3000,
			icon = "error",
		})
		return false
	end

	file:write(contents)
	file:close()
	return true
end

function helpers.mkdir_p(path)
	local result = os.execute("mkdir -p " .. path .. " 2>/dev/null")
	return result == 0 or result == true
end

function helpers.trim(string)
	return "'" .. (string or ""):gsub("'", [['\'']]) .. "'"
end

---@param s any Value to quote (coerced to string)
---@return string Shell-safe single-quoted string
function helpers.shquote(s)
	return "'" .. tostring(s):gsub("'", [['\'']]) .. "'"
end

function helpers.safe_call(error_context, fn, default_value)
	local success, result = pcall(fn)
	if not success then
		local notify = require("utils.notify")
		notify.error(error_context, tostring(result))
		return default_value
	end
	return result
end

helpers.safe_call_with_return = helpers.safe_call

_G.helpers = helpers
return helpers
