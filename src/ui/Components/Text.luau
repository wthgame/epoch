local Epoch = script:FindFirstAncestor("Epoch")

local Theme = require(Epoch.UI.Theme)
local Types = require(Epoch.UI.Types)
local Vide = require(Epoch.Vide)
local exhaustiveMatch = require(Epoch.Utils.exhaustiveMatch)

local create = Vide.create
local dissolve = Vide.dissolve

type Align = "start" | "mid" | "end"

export type TextProps = {
	name: Vide.As<string>?,

	text: Vide.As<string>?,
	transparency: Vide.As<number>?,
	size: Vide.As<number>?,
	color: Vide.As<Color3>?,
	richText: Vide.As<boolean>?,
	wrap: Vide.As<boolean>?,
	weight: Vide.As<Enum.FontWeight>?,

	alignX: Vide.As<Align>?,
	alignY: Vide.As<Align>?,

	layout: Types.LayoutProps?,
}

local function Text(props: TextProps): TextLabel
	local layout = props.layout or {} :: never
	local alignX, alignY = props.alignX or "start", props.alignY or "start"

	return create "TextLabel" {
		BackgroundTransparency = 1,

		Name = props.name or props.text or "Text",

		Text = props.text or Theme.text,
		TextTransparency = props.transparency,
		TextSize = props.size,
		TextColor3 = props.color,
		RichText = props.richText,
		TextWrap = props.wrap,
		FontFace = dissolve(function(read)
			return Font.fromName("SourceSansPro", read(props.weight) or Enum.FontWeight.Regular)
		end),

		TextXAlignment = dissolve(function(read)
			local align: Align = read(alignX)
			return if align == "start"
				then Enum.TextXAlignment.Left
				elseif align == "mid" then Enum.TextXAlignment.Center
				elseif align == "end" then Enum.TextXAlignment.Right
				else exhaustiveMatch(align)
		end),
		TextYAlignment = dissolve(function(read)
			local align: Align = read(alignY)
			return if align == "start"
				then Enum.TextYAlignment.Top
				elseif align == "mid" then Enum.TextYAlignment.Center
				elseif align == "end" then Enum.TextYAlignment.Bottom
				else exhaustiveMatch(align)
		end),

		Position = layout.position,
		AnchorPoint = layout.anchorPoint,
		AutomaticSize = layout.automaticSize or Enum.AutomaticSize.XY,
		Size = layout.size,
		LayoutOrder = layout.layoutOrder,
		ZIndex = layout.zIndex,
		Visible = layout.visible,
	}
end

return Text
