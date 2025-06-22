local TextService = game:GetService("TextService")

local Padding = require("@src/ui/components/Padding")
local Round = require("@src/ui/components/Round")
local Text = require("@src/ui/components/Text")
local theme = require("@src/ui/theme")
local types = require("@src/ui/types")
local vide = require("@src/vide")

local create = vide.create
local dissolve = vide.dissolve
local source = vide.source
local changed = vide.actions.changed
local read = vide.read
local spring = vide.spring

export type TextFieldProps = {
	name: vide.As<string>?,

	text: vide.As<string>,
	placeholder_text: vide.As<string>?,
	size: vide.As<number>?,
	weight: vide.As<Enum.FontWeight>?,
	on_input: ((new: string) -> ())?,
	on_unfocused: ((new: string, enter: boolean) -> ())?,

	corner_radius: vide.As<UDim>?,
	focus_ring: vide.As<Color3>?,

	colors: {
		base: vide.As<Color3>?,
		text: vide.As<Color3>?,
		placeholder: vide.As<Color3>?,
	}?,

	layout: types.LayoutProps?,

	[number]: vide.Child?,
}

local function TextField(props: TextFieldProps)
	local colors = props.colors or {} :: never
	local layout = props.layout or {} :: never

	local textSize = props.size or 14
	local textFont = dissolve(function(read)
		return Font.fromName("SourceSansPro", read(props.weight) or Enum.FontWeight.Regular)
	end)

	local focused = source(false)
	local canvasPosition = source(Vector2.zero)

	local function isInputEmpty()
		return #read(props.text) == 0
	end

	local placeholderVisibility = spring(function()
		return if isInputEmpty() then 0 else 1
	end, 0.2)

	return create "ImageButton" {
		Name = props.name or "TextField",

		BackgroundColor3 = colors.base or theme.mantle,

		Position = layout.position,
		AnchorPoint = layout.anchorPoint,
		AutomaticSize = layout.automaticSize,
		Size = layout.size or UDim2.new(1, 0, 0, 32),
		LayoutOrder = layout.layoutOrder,
		ZIndex = layout.zIndex,
		Visible = layout.visible,
		ClipsDescendants = true,

		Padding { all = UDim.new(0, 2) },

		props.corner_radius and Round { round = props.corner_radius },

		props.focus_ring and create "UIStroke" {
			Name = "Ring",
			-- Color = spring(function()
			-- 	return if focused()
			-- 		then read(props.colors.borderActive)
			-- 		elseif guiState() == Enum.GuiState.Hover then read(props.colors.borderHover)
			-- 		else read(props.colors.border)
			-- end, 0.2),
			Color = props.focus_ring,
			Thickness = spring(function()
				return if focused() then 2 else 6
			end, 0.4),
			Transparency = spring(function()
				return if focused() then 0 else 1
			end, 0.2),
		},

		create "ScrollingFrame" {
			Name = "Scroller",

			Position = function()
				return UDim2.fromOffset(read(textSize), 0)
			end,
			Size = function()
				return UDim2.new(1, -read(textSize) * 2, 1, 0)
			end,
			ZIndex = 2,

			CanvasPosition = spring(canvasPosition, 0.2),
			CanvasSize = spring(function()
				local size = TextService:GetTextSize(
					read(props.text),
					read(textSize),
					-- read(textFont),
					Enum.Font.SourceSans,
					Vector2.new(math.huge, math.huge)
				)
				return UDim2.fromOffset(size.X, size.Y)
			end, 0.1),

			BackgroundTransparency = 1,
			ScrollBarThickness = 0,
			ScrollingDirection = Enum.ScrollingDirection.X,
			ClipsDescendants = false,

			create "TextBox" {
				Name = "Input",
				Size = UDim2.new(1, 0, 1, 0),

				FontFace = textFont,
				PlaceholderText = "",
				Text = props.text,
				TextColor3 = colors.text or theme.text,
				TextSize = textSize,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,

				BackgroundTransparency = 1,

				props.on_input and changed("Text", props.on_input),
				changed("CursorPosition", function(cursor)
					canvasPosition(TextService:GetTextSize(
						string.sub(read(props.text), 1, cursor),
						read(textSize),
						-- read(textFont),
						Enum.Font.SourceSans,
						Vector2.new(math.huge, math.huge)
					))
				end),

				Focused = function()
					focused(true)
				end,
				FocusLost = if props.on_unfocused
					then function(enter)
						focused(false)
						props.on_unfocused(read(props.text), enter)
					end
					else function()
						focused(false)
					end,
			},
		},

		Text {
			name = "Placeholder",

			text = props.placeholder_text or "Click to type",
			size = textSize,
			weight = props.weight,
			color = colors.placeholder or theme.subtext0,
			align_y = "mid",
			transparency = placeholderVisibility,
			visible = function()
				return placeholderVisibility() < 0.995
			end,

			layout = {
				size = dissolve(function(read)
					return UDim2.new(1, read(textSize), 1, 0)
				end),
				automaticSize = Enum.AutomaticSize.None,
				position = function()
					return UDim2.new(0, (placeholderVisibility() + 1) * read(textSize), 0.5, 0)
				end,
				anchorPoint = Vector2.new(0, 0.5),
			},
		},

		table.unpack(props),
	}
end

return TextField
