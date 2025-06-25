local Epoch = script:FindFirstAncestor("Epoch")

local MouseIcon = require(Epoch.MouseIcon)
local Text = require(Epoch.UI.Components.Text)
local Theme = require(Epoch.UI.Theme)
local Types = require(Epoch.UI.Types)
local Vide = require(Epoch.Vide)

local create = Vide.create
local read = Vide.read
local spring = Vide.spring
local source = Vide.source
local cleanup = Vide.cleanup

export type ButtonProps = {
	name: Vide.As<string>?,

	label: Vide.As<string>?,
	onActivated: (() -> ())?,

	cornerRadius: Vide.As<UDim>?,

	colors: {
		base: Vide.As<Color3>?,
		hover: Vide.As<Color3>?,
		foreground: Vide.As<Color3>?,
	}?,

	layout: Types.LayoutProps?,

	[number]: Vide.Child?,
}

local function Button(props: ButtonProps)
	local colors = props.colors or {} :: never
	local layout = props.layout or {} :: never

	local foreground = colors.foreground or Theme.text
	local hover = source(false)

	local pointingIcon = MouseIcon(MouseIcon.Icons.PointingHand)
	cleanup(pointingIcon)

	return create "ImageButton" {
		Name = props.name or "Button",

		BackgroundColor3 = spring(function()
			return hover() and read(colors.hover) or read(colors.base) or Theme.surface0()
		end, 0.2),
		Activated = props.onActivated,

		Position = layout.position,
		AnchorPoint = layout.anchorPoint,
		Size = layout.size,
		AutomaticSize = layout.automaticSize,
		LayoutOrder = layout.layoutOrder,
		Visible = layout.visible,
		ZIndex = layout.zIndex,

		MouseEnter = function()
			hover(true)
			pointingIcon:push()
		end,
		MouseLeave = function()
			hover(false)
			pointingIcon:pop()
		end,

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
