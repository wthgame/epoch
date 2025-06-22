local function exhaustive_match(value: never): never
	error(`Unknown value in exhaustive match: {value}`)
end

return exhaustive_match
