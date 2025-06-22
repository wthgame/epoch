local TextField = require("./TextField")
local UILabs = require("@pkgs/ui-labs")
local theme = require("@src/ui/theme")
local vide = require("@src/Vide")

return UILabs.CreateVideStory(
	{
		vide = vide,
		controls = {
			placeholder = "Type to search potential victims...",
			focusRing = Color3.fromRGB(60, 90, 210),
		},
	},
	function(props: UILabs.VideProps)
		return theme.ThemePreview({
			fillDirection = "horizontal",
			render = function()
				local text = vide.source("")

				return TextField {
					text = text,
					placeholder_text = props.controls.placeholder,
					on_input = function(new)
						text(new)
					end,

					corner_radius = UDim.new(0, 4),
					focusRing = props.controls.focusRing,

					colors = {},
				}
			end,
		})
	end :: any
)
