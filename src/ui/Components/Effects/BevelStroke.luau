local Epoch = script:FindFirstAncestor("Epoch")

local Bevel = require(Epoch.UI.Components.Effects.Bevel)
local Round = require(Epoch.UI.Components.Layouts.Round)
local Vide = require(Epoch.Vide)

local create = Vide.create
local dissolve = Vide.dissolve

local HIGHLIGHT = Color3.new(1, 1, 1)
local SHADOW = Color3.new(0, 0, 0)

export type BevelStrokeProps = Bevel.BevelProps & {
	round: Vide.As<UDim>?,
}

--- Creates a bevel effect with gradient outlines.
local function BevelStroke(props: BevelStrokeProps)
	local top = dissolve(function(read)
		return if read(props.invert) then SHADOW else HIGHLIGHT
	end)

	local bottom = dissolve(function(read)
		return if read(props.invert) then HIGHLIGHT else SHADOW
	end)

	local thickness = props.thickness or 1
	local transparency = props.transparency or 0.75

	return create "Frame" {
		Name = props.name or "BevelStroke",

		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = dissolve(function(read)
			return UDim2.new(1, -read(thickness) * 2, 1, -read(thickness) * 2)
		end),
		ZIndex = 1000,

		create "Frame" {
			Name = "Top",
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),

			props.round and Round { round = props.round },

			create "UIStroke" {
				Color = top,
				Thickness = thickness,

				create "UIGradient" {
					Transparency = dissolve(function(read)
						return NumberSequence.new({
							NumberSequenceKeypoint.new(0, read(transparency)),
							NumberSequenceKeypoint.new(0.5, 1),
							NumberSequenceKeypoint.new(1, 1),
						})
					end),
					Rotation = 90,
				},
			},
		},

		create "Frame" {
			Name = "Bottom",
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),

			props.round and Round { round = props.round },

			create "UIStroke" {
				Color = bottom,
				Thickness = thickness,

				create "UIGradient" {
					Transparency = dissolve(function(read)
						return NumberSequence.new({
							NumberSequenceKeypoint.new(0, 1),
							NumberSequenceKeypoint.new(0.5, 1),
							NumberSequenceKeypoint.new(1, read(transparency)),
						})
					end),
					Rotation = 90,
				},
			},
		},
	}
end

return BevelStroke
