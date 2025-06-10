local function iterArray<VI, VO>(tbl: { VI }, iterator: (VI, index: number) -> VO): { VO }
	local output = {}
	for index, value in tbl do
		table.insert(output, iterator(value, index))
	end
	print(output)
	return output
end

return iterArray
