-- {{{ Helper functions


function dbg(vars)
	local text = ""
	if type(vars) == "table" then
		for i=1, #vars do text = text .. vars[i] .. " | " end
	elseif type(vars) == "string" then
		text = vars
	end
	naughty.notify({ text = text, timeout = 0 })
end

function clean(string)
	s = string.gsub(string, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

function file_exists(file)
	local cmd = "/bin/bash -c 'if [ -e " .. file .. " ]; then echo true; fi;'"
	local fh = io.popen(cmd)

	s = clean(fh:read('*a'))

	if s == 'true' then return true else return nil end
end

--% Find the path of an application, return nil of doesn't exist
----@ app (string) Text of the first parameter
----@ return string of app path, or nil (remember, only nil and false is false in lua)
function whereis_app(app)
	local fh = io.popen('which ' .. app)
	s = clean(fh:read('*a'))

	if s == "" then return nil else return s end
	return s
end

function require_safe(lib)
	if file_exists(awful.util.getdir("config") .. '/' .. lib ..'.lua') or
		file_exists(awful.util.getdir("config") .. '/' .. lib) then
			require(lib)
	end
end

-- }}}
