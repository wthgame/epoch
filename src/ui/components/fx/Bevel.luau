local vide = require("@src/vide")

local create = vide.create
local dissolve = vide.dissolve

export type BevelProps = {
	invert: vide.As<boolean>?,
	thickness: vide.As<number>?,
}

local HIGHLIGHT = Color3.new(1, 1, 1)
local SHADOW = Color3.new(0, 0, 0)

local function Bevel(props: BevelProps)
	local top = dissolve(function(read)
		return if read(props.invert) then SHADOW else HIGHLIGHT
	end)

	local bottom = dissolve(function(read)
		return if read(props.invert) then HIGHLIGHT else SHADOW
	end)

	local size = dissolve(function(read)
		return UDim2.new(1, 0, 0, read(props.thickness) or 1)
	end)

	return create "Frame" {
		Name = "Bevel",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		ZIndex = 100,

		create "Frame" {
			Name = "Top",
			Size = size,
			BackgroundColor3 = top,
			BackgroundTransparency = 0.75,
		},

		create "Frame" {
			Name = "Bottom",
			Size = size,
			BackgroundColor3 = bottom,
			BackgroundTransparency = 0.75,
			Position = UDim2.fromScale(0, 1),
			AnchorPoint = Vector2.new(0, 1),
		},
	}
end

return Bevel
