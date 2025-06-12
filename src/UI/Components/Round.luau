local Types = require("@src/Types")
local Vide = require("@pkgs/Vide")

local create = Vide.create

export type RoundProps = {
	name: Types.ReadAs<string>?,

	round: Types.ReadAs<UDim>?,
}

local ZERO_UDIM = UDim.new()

local function Round(props: RoundProps)
	return create "UICorner" {
		Name = props.name or "Round",
		CornerRadius = props.round or ZERO_UDIM,
	}
end

return Round
