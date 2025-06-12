local Oklab = require("@pkgs/Oklab")
local UILabs = require("@pkgs/UILabs")
local Vide = require("@pkgs/Vide")
local iterArray = require("@utils/Collections/iterArray")

local create, source = Vide.create, Vide.source

local HUES = {}
local LIGHTNESSES = {}

do
	for hue = 0, 350, 10 do
		table.insert(HUES, hue)
	end

	for lightness = 1, 0, -0.05 do
		table.insert(LIGHTNESSES, lightness)
	end
end

return UILabs.CreateVideStory({
	vide = Vide,
	controls = {
		chroma = UILabs.Slider(0.15, 0, 1, 0.05),
	},
}, function(props)
	local selectedHue = source(0)
	local selectedLightness = source(0)

	return create "Frame" {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),

		create "Frame" {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,

			create "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			create "TextLabel" {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				AutomaticSize = Enum.AutomaticSize.Y,

				Text = function()
					local lightness = selectedLightness()
					local chroma = props.controls.chroma()
					local hue = selectedHue()

					return `Lightness: {math.round(lightness * 100)}% ({string.format("%.2f", lightness)})`
						.. `\nChroma: {math.round(chroma * 100)}% ({string.format("%.2f", chroma)})`
						.. `\nHue: {hue}° ({string.format("%.2f", hue / 360)})`
				end,
				TextColor3 = Color3.new(1, 1, 1),
				TextSize = 14,
			},

			iterArray(LIGHTNESSES, function(lightness)
				return create "Frame" {
					AutomaticSize = Enum.AutomaticSize.XY,

					create "UIListLayout" {
						SortOrder = Enum.SortOrder.LayoutOrder,
						FillDirection = Enum.FillDirection.Horizontal,
					},

					iterArray(HUES, function(hue)
						return create "ImageButton" {
							BorderColor3 = Color3.new(1, 1, 1),
							BorderSizePixel = function()
								return if selectedHue() == hue
										and math.round(selectedLightness() * 100) == math.round(lightness * 100)
									then 4
									else 0
							end,
							BorderMode = Enum.BorderMode.Inset,

							Size = UDim2.fromOffset(24, 24),
							BackgroundColor3 = function()
								return Oklab.linear_srgb_to_color3(
									Oklab.oklab_to_linear_srgb(
										Oklab.oklch_to_oklab(Vector3.new(lightness, props.controls.chroma(), hue / 360))
									)
								)
							end,

							Activated = function()
								selectedHue(hue)
								selectedLightness(lightness)
							end,
						}
					end),
				}
			end),
		},
	}
end)
