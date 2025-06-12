local TextService = game:GetService("TextService")

local Epoch = script:FindFirstAncestor("Epoch")
local Bevel = require(Epoch.UI.Components.Fx.Bevel)
local Padding = require(Epoch.UI.Components.Padding)
local Round = require(Epoch.UI.Components.Round)
local Text = require(Epoch.UI.Components.Text)
local Theme = require(Epoch.UI.Theme)
local Types = require(Epoch.Types)
local Vide = require(Epoch.Packages.Vide)
local changed = require(Epoch.Utils.Vide.Actions.changed)
local dissolve = require(Epoch.Utils.Vide.dissolve)

local create, source, spring, read = Vide.create, Vide.source, Vide.spring, Vide.read

export type TextFieldProps = {
	name: Types.ReadAs<string>?,

	text: Types.ReadAs<string>,
	placeholderText: Types.ReadAs<string>?,
	size: Types.ReadAs<number>?,
	weight: Types.ReadAs<Enum.FontWeight>?,
	onInput: ((new: string) -> ())?,
	onUnfocused: ((new: string, enter: boolean) -> ())?,

	cornerRadius: Types.ReadAs<UDim>?,
	focusRing: Types.ReadAs<Color3>?,

	colors: {
		base: Types.ReadAs<Color3>?,
		text: Types.ReadAs<Color3>?,
		placeholder: Types.ReadAs<Color3>?,
	}?,

	layout: Types.LayoutProps?,
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

		BackgroundColor3 = colors.base or Theme.mantle,

		Position = layout.position,
		AnchorPoint = layout.anchorPoint,
		AutomaticSize = layout.automaticSize,
		Size = layout.size or UDim2.new(1, 0, 0, 32),
		LayoutOrder = layout.layoutOrder,
		ZIndex = layout.zIndex,
		Visible = layout.visible,
		ClipsDescendants = true,

		Padding { all = UDim.new(0, 2) },

		props.cornerRadius and Round { round = props.cornerRadius },

		Bevel {
			invert = false,
			thickness = 1,
			cornerRadius = props.cornerRadius,
		},

		props.focusRing and create "UIStroke" {
			Name = "Ring",
			-- Color = spring(function()
			-- 	return if focused()
			-- 		then read(props.colors.borderActive)
			-- 		elseif guiState() == Enum.GuiState.Hover then read(props.colors.borderHover)
			-- 		else read(props.colors.border)
			-- end, 0.2),
			Color = props.focusRing,
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
				return UDim2.new(1, -Vide.read(textSize) * 2, 1, 0)
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
				TextColor3 = colors.text or Theme.text,
				TextSize = textSize,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,

				BackgroundTransparency = 1,

				props.onInput and changed("Text", props.onInput),
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
				FocusLost = if props.onUnfocused
					then function(enter)
						focused(false)
						props.onUnfocused(read(props.text), enter)
					end
					else function()
						focused(false)
					end,
			},
		},

		Text {
			name = "Placeholder",

			text = props.placeholderText or "Click to type",
			size = textSize,
			weight = props.weight,
			color = colors.placeholder or Theme.subtext0,
			alignY = "mid",
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
	}
end

return TextField
