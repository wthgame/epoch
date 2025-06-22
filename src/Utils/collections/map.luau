local function map<KI, VI, KO, VO>(tbl: { [KI]: VI }, mapper: (KI, VI) -> (KO, VO)): { [KO]: VO }
	local result = {}
	for inKey, inValue in tbl do
		local outKey, outValue = mapper(inKey, inValue)
		assert(result[outKey] == nil, "Duplicate key")
		result[outKey] = outValue
	end
	return result
end

return map
