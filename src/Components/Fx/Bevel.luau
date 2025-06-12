local Types = require("@src/Types")
local Vide = require("@pkgs/Vide")
local dissolve = require("@utils/Vide/dissolve")

local create, read = Vide.create, Vide.read

type BevelStrokeLayerProps = {
	invert: Types.ReadAs<boolean>?,
	thickness: Types.ReadAs<number>,
	cornerRadius: Types.ReadAs<UDim>?,
	placement: Types.ReadAs<"top" | "bottom">,
}

local function BevelStrokeLayer(props: BevelStrokeLayerProps)
	local isShaded = dissolve(function()
		-- true, top -> shaded
		-- true, bottom -> not shaded
		-- false, top -> not shaded
		-- false, bottom -> shaded
		-- I am genius
		return read(props.invert) == (read(props.placement) ~= "top")
	end)

	return create "Frame" {
		Name = "BevelStrokeLayer",

		Position = dissolve(function(read)
			return UDim2.fromScale(0, if read(props.placement) == "top" then 0 else 1)
		end),
		AnchorPoint = dissolve(function(read)
			return Vector2.new(0, if read(props.placement) == "top" then 0 else 1)
		end),
		Size = UDim2.new(1, 0, 0, 32),
		BackgroundTransparency = 1,

		props.cornerRadius and create "UICorner" {
			CornerRadius = dissolve(function(read)
				local offset = if read(props.invert) then 0 else -read(props.thickness)
				return read(props.cornerRadius) :: UDim + UDim.new(0, offset)
			end),
		},

		create "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = dissolve(function(read)
				return if read(isShaded) then Color3.new() else Color3.new(1, 1, 1)
			end),
			LineJoinMode = Enum.LineJoinMode.Round,
			Thickness = props.thickness,
			Transparency = 0,

			create "UIGradient" {
				Rotation = dissolve(function(read)
					return if read(props.placement) == "top" then 90 else -90
				end),
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0.5),
					NumberSequenceKeypoint.new(0.1, 1),
					NumberSequenceKeypoint.new(1, 1),
				}),
			},
		},
	}
end

export type BevelProps = {
	invert: Types.ReadAs<boolean>?,
	thickness: Types.ReadAs<number>?,
	cornerRadius: Types.ReadAs<UDim>?,
}

local function Bevel(props: BevelProps)
	local thickness = props.thickness or 1

	return create "Frame" {
		Name = "Bevel",

		Position = dissolve(function(read)
			return if read(props.invert) then UDim2.new() else UDim2.fromOffset(read(thickness), read(thickness))
		end),
		Size = dissolve(function(read)
			return if read(props.invert)
				then UDim2.fromScale(1, 1)
				else UDim2.new(1, -read(thickness) * 2, 1, -read(thickness) * 2)
		end),
		BackgroundTransparency = 1,
		ZIndex = 100,

		BevelStrokeLayer {
			invert = props.invert,
			thickness = thickness,
			cornerRadius = props.cornerRadius,
			placement = "top",
		},

		BevelStrokeLayer {
			invert = props.invert,
			thickness = thickness,
			cornerRadius = props.cornerRadius,
			placement = "bottom",
		},
	}
end

return Bevel
