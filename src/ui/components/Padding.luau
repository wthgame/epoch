local vide = require("@src/vide")

local create = vide.create
local dissolve = vide.dissolve

export type PaddingProps = {
	name: vide.As<string>?,

	default: vide.As<UDim>?,
	x: vide.As<UDim>?,
	y: vide.As<UDim>?,
	left: vide.As<UDim>?,
	right: vide.As<UDim>?,
	top: vide.As<UDim>?,
	bottom: vide.As<UDim>?,
}

local ZERO_UDIM = UDim.new()

local function Padding(props: PaddingProps)
	return create "UIPadding" {
		Name = props.name or "Padding",

		PaddingLeft = dissolve(function(read)
			return read(props.left) or read(props.x) or read(props.default) or ZERO_UDIM
		end),
		PaddingRight = dissolve(function(read)
			return read(props.right) or read(props.x) or read(props.default) or ZERO_UDIM
		end),
		PaddingTop = dissolve(function(read)
			return read(props.top) or read(props.y) or read(props.default) or ZERO_UDIM
		end),
		PaddingBottom = dissolve(function(read)
			return read(props.bottom) or read(props.y) or read(props.default) or ZERO_UDIM
		end),
	}
end

return Padding
