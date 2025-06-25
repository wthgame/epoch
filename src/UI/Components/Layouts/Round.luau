local Epoch = script:FindFirstAncestor("Epoch")

local Vide = require(Epoch.Vide)

local create = Vide.create

export type RoundProps = {
	name: Vide.As<string>?,

	round: Vide.As<UDim>?,
}

local ZERO_UDIM = UDim.new()

local function Round(props: RoundProps)
	return create "UICorner" {
		Name = props.name or "Round",
		CornerRadius = props.round or ZERO_UDIM,
	}
end

return Round
