local Epoch = script:FindFirstAncestor("Epoch")

local BevelStroke = require(Epoch.UI.Components.Effects.BevelStroke)
local Round = require(Epoch.UI.Components.Layouts.Round)
local TextField = require(script.Parent.TextField)
local Theme = require(Epoch.UI.Theme)
local UILabs = require(Epoch.Packages.UILabs)
local Vide = require(Epoch.Vide)

return UILabs.CreateVideStory({
	vide = Vide,
	controls = {
		placeholder = "Type to search potential victims...",
		focusRing = Color3.fromRGB(60, 90, 210),
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
			local text = Vide.source("")

			return TextField {
				text = text,
				placeholderText = props.controls.placeholder,

				onInput = function(new)
					text(new)
				end,

				focusRing = props.controls.focusRing,

				Round { round = round },

				BevelStroke {
					invert = true,
					round = round,
				},
			}
		end,
	})
end)
