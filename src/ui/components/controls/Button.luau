local Text = require("@src/ui/components/Text")
local theme = require("@src/ui/theme")
local types = require("@src/ui/types")
local vide = require("@src/vide")

local create = vide.create

export type ButtonProps = {
	name: vide.As<string>?,

	label: vide.As<string>?,
	on_activated: (() -> ())?,

	corner_radius: vide.As<UDim>?,

	colors: {
		base: vide.As<Color3>?,
		foreground: vide.As<Color3>?,
	}?,

	layout: types.LayoutProps?,

	[number]: vide.Child?,
}

local function Button(props: ButtonProps)
	local colors = props.colors or {} :: never
	local layout = props.layout or {} :: never

	local foreground = colors.foreground or theme.text

	return create "ImageButton" {
		Name = props.name or "Button",

		BackgroundColor3 = colors.base,
		Activated = props.on_activated,

		Position = layout.position,
		AnchorPoint = layout.anchorPoint,
		Size = layout.size,
		AutomaticSize = layout.automaticSize,
		LayoutOrder = layout.layoutOrder,
		Visible = layout.visible,
		ZIndex = layout.zIndex,

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

		table.unpack(props),
	}
end

return Button
