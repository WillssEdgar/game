local json = {}

local function escapeString(str)
	local replacements = {
		['\\'] = '\\\\',
		['"']  = '\\"',
		['\b'] = '\\b',
		['\f'] = '\\f',
		['\n'] = '\\n',
		['\r'] = '\\r',
		['\t'] = '\\t',
	}
	-- replace control chars and backslash/quote
	return str:gsub('[\\"%z\1-\31]', function(c)
		return replacements[c] or string.format('\\u%04x', c:byte())
	end)
end

local function isArray(t)
	local count, maxIndex = 0, 0
	for k, v in pairs(t) do
		if type(k) == 'number' and k > 0 and math.floor(k) == k then
			count = count + 1
			if k > maxIndex then maxIndex = k end
		else
			return false
		end
	end
	return maxIndex == count
end

function json.encode(value)
	local t = type(value)
	if t == 'nil' then
		return 'null'
	elseif t == 'boolean' or t == 'number' then
		return tostring(value)
	elseif t == 'string' then
		return '"' .. escapeString(value) .. '"'
	elseif t == 'table' then
		local items = {}
		if isArray(value) then
			for i = 1, #value do
				items[#items + 1] = json.encode(value[i])
			end
			return '[' .. table.concat(items, ',') .. ']'
		else
			for k, v in pairs(value) do
				if type(k) ~= 'string' then
					error('JSON object keys must be strings', 2)
				end
				items[#items + 1] = '"' .. escapeString(k) .. '":' .. json.encode(v)
			end
			return '{' .. table.concat(items, ',') .. '}'
		end
	else
		error('Cannot JSON-encode type `' .. t .. '`', 2)
	end
end

return json
