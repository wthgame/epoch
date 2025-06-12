local Theme = require("@src/Theme")
local Types = require("@src/Types")
local Vide = require("@pkgs/Vide")
local dissolve = require("@utils/Vide/dissolve")
local exhaustiveMatch = require("@utils/exhaustiveMatch")

type Align = "start" | "mid" | "end"

export type TextProps = {
	name: Types.ReadAs<string>?,

	text: Types.ReadAs<string>?,
	transparency: Types.ReadAs<number>?,
	size: Types.ReadAs<number>?,
	color: Types.ReadAs<Color3>?,
	richText: Types.ReadAs<boolean>?,
	wrap: Types.ReadAs<boolean>?,
	weight: Types.ReadAs<Enum.FontWeight>?,

	alignX: Types.ReadAs<Align>?,
	alignY: Types.ReadAs<Align>?,

	layout: Types.LayoutProps?,
}

local function Text(props: TextProps): TextLabel
	local layout = props.layout or {} :: never
	local alignX, alignY = props.alignX or "start", props.alignY or "start"

	return Vide.create "TextLabel" {
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
