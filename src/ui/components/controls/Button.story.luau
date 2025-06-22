local Button = require("./Button")
local UILabs = require("@pkgs/ui-labs")
local theme = require("@src/ui/theme")
local vide = require("@src/vide")

return UILabs.CreateVideStory(
	{
		vide = vide,
		controls = {
			label = "Call Airstrike",
			color = Color3.fromRGB(60, 90, 210),
		},
	},
	function(props: UILabs.VideProps)
		return theme.ThemePreview({
			fillDirection = "horizontal",
			render = function()
				return Button {
					label = props.controls.label,
					corner_radius = UDim.new(0, 4),

					colors = {
						base = props.controls.color,
					},

					layout = {
						size = UDim2.fromOffset(48, 32),
					},
				}
			end,
		})
	end :: any
)
