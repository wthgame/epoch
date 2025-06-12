local Bevel = require("@components/Fx/Bevel")
local Text = require("@components/Text")
local Theme = require("@src/Theme")
local Types = require("@src/Types")
local Vide = require("@pkgs/Vide")

local create = Vide.create

export type ButtonProps = {
	name: Types.ReadAs<string>?,

	label: Types.ReadAs<string>?,
	onActivated: (() -> ())?,

	cornerRadius: Types.ReadAs<UDim>?,

	colors: {
		base: Types.ReadAs<Color3>?,
		foreground: Types.ReadAs<Color3>?,
	}?,

	layout: Types.LayoutProps?,
}

local function Button(props: ButtonProps)
	local colors = props.colors or {} :: never
	local layout = props.layout or {} :: never

	local foreground = colors.foreground or Theme.text

	return create "ImageButton" {
		Name = props.name or "Button",

		BackgroundColor3 = colors.base,
		Activated = props.onActivated,

		Position = layout.position,
		AnchorPoint = layout.anchorPoint,
		Size = layout.size,
		AutomaticSize = layout.automaticSize,
		LayoutOrder = layout.layoutOrder,
		Visible = layout.visible,
		ZIndex = layout.zIndex,

		Bevel {
			invert = true,
			thickness = 1,
			cornerRadius = props.cornerRadius,
		},

		create "Frame" {
			Name = "Content",

			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,

			props.label and Text {
				text = props.label,
				color = foreground,
				size = 14,
			},
		},
	}
end

return Button
