local function formatShortVersion(version: vector)
	local major, minor, patch = version.x, version.y, version.z
	return if patch ~= 0
		then string.format("%d.%d.%d", major, minor, patch)
		elseif minor ~= 0 then string.format("%d.%d", major, minor)
		else string.format("%d", major)
end

return formatShortVersion
