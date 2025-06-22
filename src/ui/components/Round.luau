local vide = require("@src/vide")

local create = vide.create

export type RoundProps = {
	name: vide.As<string>?,

	round: vide.As<UDim>?,
}

local ZERO_UDIM = UDim.new()

local function Round(props: RoundProps)
	return create "UICorner" {
		Name = props.name or "Round",
		corner_radius = props.round or ZERO_UDIM,
	}
end

return Round
