local Types = require("@src/Types")
local Vide = require("@pkgs/Vide")
local dissolve = require("@utils/Vide/dissolve")

local create = Vide.create

export type PaddingProps = {
	name: Types.ReadAs<string>?,

	default: Types.ReadAs<UDim>?,
	x: Types.ReadAs<UDim>?,
	y: Types.ReadAs<UDim>?,
	left: Types.ReadAs<UDim>?,
	right: Types.ReadAs<UDim>?,
	top: Types.ReadAs<UDim>?,
	bottom: Types.ReadAs<UDim>?,
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
