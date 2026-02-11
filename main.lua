--- @sync entry

local function is_folder_only(path)
	local p = io.popen(string.format("ls -1A %s 2>/dev/null", ya.quote(path)), "r")
	if p == nil then
		return false
	end

	local count = 0
	local name = nil
	for line in p:lines() do
		count = count + 1
		name = line
	end
	p:close()

	if count ~= 1 then
		return false
	end

	local p2 = io.popen(string.format("test -d %s && echo 1 || echo 0", ya.quote(path .. "/" .. name)), "r")
	local is_dir = p2:read("*all"):match("1")
	p2:close()
	return is_dir == "1"
end

local function get_innermost_directory(path)
	local innermost = path
	if is_folder_only(innermost) then
		local dirs = io.popen(string.format("ls -1A %s 2>/dev/null", ya.quote(path)), "r")
		if dirs == nil then
			return innermost
		end
		local dir = dirs:read("*l")
		dirs:close()
		if dir then
			return get_innermost_directory(innermost .. "/" .. dir)
		end
	end
	return innermost
end

local function setup(self, opts)
	self.open_multi = opts.open_multi
	self.innermost = opts.innermost
end

local function entry(self)
	local h = cx.active.current.hovered
	if h == nil then
		return
	end

	if h.cha.is_dir then
		if self.innermost then
			local innermost = get_innermost_directory(tostring(h.url))
			ya.emit("cd", { innermost })
		else
			ya.emit("enter", {})
		end
	else
		ya.emit("open", { hovered = not self.open_multi })
	end
end

return {
	entry = entry,
	setup = setup,
}
