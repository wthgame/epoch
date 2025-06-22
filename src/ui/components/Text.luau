local exhaustive_match = require("@src/utils/exhaustive_match")
local theme = require("@src/ui/theme")
local types = require("@src/ui/types")
local vide = require("@src/vide")

local create = vide.create
local dissolve = vide.dissolve

type Align = "start" | "mid" | "end"

export type TextProps = {
	name: vide.As<string>?,

	text: vide.As<string>?,
	transparency: vide.As<number>?,
	size: vide.As<number>?,
	color: vide.As<Color3>?,
	rich_text: vide.As<boolean>?,
	wrap: vide.As<boolean>?,
	weight: vide.As<Enum.FontWeight>?,

	align_x: vide.As<Align>?,
	align_y: vide.As<Align>?,

	layout: types.LayoutProps?,
}

local function Text(props: TextProps): TextLabel
	local layout = props.layout or {} :: never
	local align_x, align_y = props.align_x or "start", props.align_y or "start"

	return create "TextLabel" {
		BackgroundTransparency = 1,

		Name = props.name or props.text or "Text",

		Text = props.text or theme.text,
		TextTransparency = props.transparency,
		TextSize = props.size,
		TextColor3 = props.color,
		rich_text = props.rich_text,
		TextWrap = props.wrap,
		FontFace = dissolve(function(read)
			return Font.fromName("SourceSansPro", read(props.weight) or Enum.FontWeight.Regular)
		end),

		TextXAlignment = dissolve(function(read)
			local align: Align = read(align_x)
			return if align == "start"
				then Enum.TextXAlignment.Left
				elseif align == "mid" then Enum.TextXAlignment.Center
				elseif align == "end" then Enum.TextXAlignment.Right
				else exhaustive_match(align)
		end),
		TextYAlignment = dissolve(function(read)
			local align: Align = read(align_y)
			return if align == "start"
				then Enum.TextYAlignment.Top
				elseif align == "mid" then Enum.TextYAlignment.Center
				elseif align == "end" then Enum.TextYAlignment.Bottom
				else exhaustive_match(align)
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
