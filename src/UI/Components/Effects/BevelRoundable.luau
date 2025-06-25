local Epoch = script:FindFirstAncestor("Epoch")

local Bevel = require(Epoch.UI.Components.Effects.Bevel)
local BevelStroke = require(Epoch.UI.Components.Effects.BevelStroke)
local Vide = require(Epoch.Vide)

local dissolve = Vide.dissolve

export type BevelRoundableProps = BevelStroke.BevelStrokeProps

--- Creates a bevel effect with specifiyable rounded corners or straight lines.
local function BevelRoundable(props: BevelRoundableProps)
	return dissolve(function(read)
		local round: UDim? = read(props.round)
		if round then
			if round.Scale == 0 and round.Offset == 0 then
				return Bevel(props)
			end
		end
		return BevelStroke(props)
	end)
end

return BevelRoundable
