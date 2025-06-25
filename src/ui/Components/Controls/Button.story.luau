local Epoch = script:FindFirstAncestor("Epoch")

local BevelStroke = require(Epoch.UI.Components.Effects.BevelStroke)
local Button = require(script.Parent.Button)
local Round = require(Epoch.UI.Components.Layouts.Round)
local Theme = require(Epoch.UI.Theme)
local UILabs = require(Epoch.Packages.UILabs)
local Vide = require(Epoch.Vide)

return UILabs.CreateVideStory({
	vide = Vide,
	controls = {
		label = "Call Airstrike",
		color = Color3.fromRGB(60, 90, 210),
		hover = Color3.fromRGB(90, 120, 240),
		roundScale = UILabs.Slider(0, 0, 1, 0.1),
		roundPx = UILabs.Slider(4, 0, 16, 2),
	},
}, function(props: UILabs.VideProps)
	local function round()
		return UDim.new(props.controls.roundScale(), props.controls.roundPx())
	end

	return Theme.ThemePreview({
		fillDirection = "horizontal",
		render = function()
			return Button {
				label = props.controls.label,

				colors = {
					base = props.controls.color,
					hover = props.controls.hover,
				},

				layout = {
					size = UDim2.fromOffset(128, 32),
				},

				Round { round = round },

				BevelStroke { round = round },
			}
		end,
	})
end)
