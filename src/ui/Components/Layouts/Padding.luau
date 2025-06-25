local Epoch = script:FindFirstAncestor("Epoch")

local Vide = require(Epoch.Vide)

local create = Vide.create

export type PaddingProps = {
	name: Vide.As<string>?,

	default: Vide.As<UDim>?,
	x: Vide.As<UDim>?,
	y: Vide.As<UDim>?,
	left: Vide.As<UDim>?,
	right: Vide.As<UDim>?,
	top: Vide.As<UDim>?,
	bottom: Vide.As<UDim>?,
}

local ZERO_UDIM = UDim.new()

local function Padding(props: PaddingProps)
	return create "UIPadding" {
		Name = props.name or "Padding",
		PaddingLeft = props.left or props.x or props.default or ZERO_UDIM,
		PaddingRight = props.right or props.x or props.default or ZERO_UDIM,
		PaddingTop = props.top or props.y or props.default or ZERO_UDIM,
		PaddingBottom = props.bottom or props.y or props.default or ZERO_UDIM,
	}
end

return Padding
