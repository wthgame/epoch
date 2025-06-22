local Text = require("./text")
local UILabs = require("@pkgs/ui-labs")

local TOCAV_WIKI_PAGE = "Tower of Complexity and Volatility (ToCaV) is a Terrifying difficulty, "
	.. "ascension-based Tower located in Zone 10. It was made by Miantoz1980, ImNotFireMan123 and "
	.. "ConfirmedIlluminatix. This tower is known for its time manipulation gimmicks. It can be "
	.. "played in its own place here."

return UILabs.CreateVideStory(
	{
		vide = require("@pkgs/vide"),
		controls = {
			text = TOCAV_WIKI_PAGE,
			rgba = UILabs.RGBA(Color3.new(1, 1, 1), 0),
			size = UILabs.Slider(12, 6, 32, 2),
			wrap = true,

			align_x = UILabs.Choose({ "start", "mid", "end" }),
			align_y = UILabs.Choose({ "start", "mid", "end" }, 1),
		},
	},
	function(props: UILabs.VideProps)
		return Text {
			text = props.controls.text,
			transparency = function()
				return props.controls.rgba().Transparency
			end,
			color = function()
				return props.controls.rgba().Color
			end,
			size = props.controls.size,
			wrap = props.controls.wrap,

			align_x = props.controls.align_x,
			align_y = props.controls.align_y,

			layout = {
				position = UDim2.fromScale(0.5, 0.5),
				anchorPoint = Vector2.new(0.5, 0.5),
			},
		}
	end :: any
)
