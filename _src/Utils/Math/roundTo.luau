local function roundTo(x: number, decimalPlaces: number?)
	if decimalPlaces then
		x *= decimalPlaces
		x = math.round(x)
		return x / decimalPlaces
	else
		return math.round(x)
	end
end

return roundTo
