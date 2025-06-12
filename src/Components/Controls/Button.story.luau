local Button = require("./Button")
local Theme = require("@src/Theme")
local UILabs = require("@pkgs/UILabs")
local Vide = require("@pkgs/Vide")

return UILabs.CreateVideStory(
	{
		vide = Vide,
		controls = {
			label = "Call Airstrike",
			color = Color3.fromRGB(60, 90, 210),
		},
	},
	function(props: UILabs.VideProps)
		return Theme.ThemePreview({
			fillDirection = "horizontal",
			render = function()
				return Button {
					label = props.controls.label,
					cornerRadius = UDim.new(0, 4),

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
